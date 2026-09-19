# Recette — L06

Faite par Bastien le 2026-09-19.

- copier le tirage devrait ouvrir l'éditeur sans enregistrer la copie ; le bouton « + » plante (liens Isar d'un objet non enregistré) → Q2 retranchée en (a) ; liens lus seulement si le tirage est en base, puis `Draw.linked` (les choix en mémoire d'un tirage neuf ne se lisent pas par `toSet`)
- le compteur de joueurs doit exclure les joueurs à zéro jeton, ajouter le total de jetons concernés → C11
- tirer au sort depuis l'éditeur lève « Cannot use the Ref of drawsProvider(null) after it has been disposed » → actions passées par le service (C13)
- une fois le tirage effectué, la liste des gagnants ne s'affiche pas sans rouvrir la page → gagnants écrits avant de dater le tirage
- la copie revient avec la dernière session en requis → défauts posés à la création d'un tirage neuf seulement
- les défauts ne s'appliquent qu'aux tirages neufs ; une copie reprend tout ; un tirage tiré crée un groupe « Gagnants du tirage … » → C3, C9
- sélecteur de sessions peu pratique : une grille, toutes les sessions, garder la recherche ; nom par défaut « Tirage N°{id} » avec max id + 1 → C10, `nextName`
- ne plus proposer la suppression des tirages ; la bille affiche l'id → Q1 retranchée
- min / max de sessions sur une ligne, joueurs exclus / requis idem, sessions idem → fait
- un titre à tous les éditeurs latéraux → C12
- nombre de gagnants sous le nom → fait
- les champs joueurs et sessions restent modifiables en lecture seule → désactivés, puis :
- il faut pouvoir ouvrir et lire les options sélectionnées sans changer leur état → `readOnly` (C13)
- ok tu peux livrer le L06
