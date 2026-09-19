# Recette — L11

Faite par Bastien le 2026-09-19.

- le style de la liste des sessions n'est pas très bon, il doit respecter plus le style de la liste des sessions : une carte blanche par session, grisée pour celle passée, une bille avec le numéro, heures début / fin l'une sur l'autre, bille verte quand le joueur a badgé → cartes reprises de la liste des sessions (C2)
- agrandir les boutons Enregistrer etc. des éditeurs latéraux, ajouter un fond (couleurs pertinentes) → `FilledButton` 48 px : Enregistrer primaire, Annuler tonal, Supprimer erreur — les quatre éditeurs
- confirmer que biper un joueur depuis la liste des joueurs ouvre sa fiche → confirmé (`onScanned` → `editPlayer`, sans badger)
- renommer « Mode manuel » en « Badgeage manuel » → fait, clé partagée avec la page session
- ajouter le curseur sur les cartes de session en badgeage manuel → posé sur le `ListTile` (l'`InkWell` autour ne suffisait pas)
- ajouter un titre « Sessions », aligner « Badgeage manuel » à droite avec son switch → fait
- ajouter une légende sous la liste des sessions (présent / absent) ; l'application est utilisée par des non-techniciens, il faut expliquer ; prévoir un bouton « i » en haut à droite de chaque page → légende posée ; décision consignée dans `CLAUDE.md` ; L12 ouvert
- bloc d'info à droite du bonus « Chaque point bonus ajoute un jeton pour les tirages au sort » ; QR code plus grand, en parallèle du nom et du bonus, champ QR code non éditable sous l'image, même largeur → fait
- cliquer sur + / − dans la liste des joueurs remet le défilement en haut → `UniqueKey` du scanner retirée (C8)
- L11 OK
