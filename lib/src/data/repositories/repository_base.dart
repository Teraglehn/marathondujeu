import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/isar_client.dart';
import 'package:isar/isar.dart';

abstract class RepositoryBase<T> {
  final IsarClient isarClient;

  RepositoryBase(this.isarClient);

  Future<IsarCollection<T>> getCollection();

  Future<void> preSave(T obj) async {}
  Future<void> postSave(T obj) async {}
  Future<void> write(T obj) async {}
  Future<T> postGet(T obj) async => obj;

  Future<void> save(T obj) async {
    final collection = await getCollection();
    await transaction(() async {
      await preSave(obj);
      await collection.put(obj);
      await write(obj);
      await postSave(obj);
    });
  }

  Future<void> saveAll(Iterable<T> objs) async {
    if(objs.isEmpty) return;
    final collection = await getCollection();
    await transaction(() async {
      await Future.wait(objs.map(preSave));
      await collection.putAll(objs.toList());
      await Future.wait(objs.map(write));
      await Future.wait(objs.map(postSave));
    });
  }

  Future<void> transaction(Future Function() fn) async {
    final isar = await isarClient.db;
    await isar.writeTxn(fn);
  }

  Future<bool> delete(Id id) async {
    final isar = await isarClient.db;
    final collection = await getCollection();
    return await isar.writeTxn(() => collection.delete(id));
  }

  Future<int> deleteAll(Set<Id> ids) async {
    if(ids.isEmpty) return 0;
    final isar = await isarClient.db;
    final collection = await getCollection();
    return await isar.writeTxn(() => collection.deleteAll(ids.toList()));
  }

  Future<T?> getById(Id id) async {
    final collection = await getCollection();
    final obj = await collection.get(id);
    return obj != null ? await postGet(obj) : null;
  }

  Future<Stream<T?>> getByIdStream(Id id) async {
    final collection = await getCollection();
    return collection.watchObject(id, fireImmediately: true).asyncMap((obj) async => obj != null ? await postGet(obj) : null);
  }

  Future<List<T>> getAll() async {
    final collection = await getCollection();
    final objs = await collection.where().findAll();
    return await Future.wait(objs.map(postGet));
  }

  Future<Stream<List<T>>> getAllStream() async {
    final collection = await getCollection();
    return collection
      .watchLazy(fireImmediately: true)
      .asyncMap((_) async => await getAll());
  }

  Iterable<FilterOperation> getFiltersOnKeyword(String keyword) => [];

  List<SortProperty> getSortProperties() => [];

  Future<Query<T>> _searchQuery(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    final collection = await getCollection();
    final List<FilterOperation> filters = [];

    if (searchCriteria.keyword.isNotEmpty) {
      filters.addAll([...getFiltersOnKeyword(searchCriteria.keyword)]);
    }

    return collection.buildQuery<T>(
      filter: FilterGroup.and(filters),
      sortBy: getSortProperties(),
      offset: offset,
      limit: limit,
    );
  }

  Future<List<T>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    final query = await _searchQuery(searchCriteria, offset: offset, limit: limit);

    return await query.findAll();
  }

  Future<Stream<List<T>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    final query = await _searchQuery(searchCriteria, offset: offset, limit: limit);

    return query.watchLazy(fireImmediately: true).asyncMap((_) async => await query.findAll());
  }
}
