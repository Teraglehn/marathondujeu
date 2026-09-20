# Recette — L10

Faite par Bastien le 2026-09-19.

- l'affichage dans la liste n'est pas bon, bottom overflow, les boutons manquent de réactivité, faut diminuer la taille des boutons plus moins ; dans l'éditeur latéral utiliser plutôt un champ de largeur réduite avec − et + sur sa droite → corrigé (boutons 28 px, `setState` au clic, champ de 100 px)
- ajoute une couleur de fond sous les boutons + / − → `IconButton.filledTonal`
- dans l'éditeur latéral, place des espaces entre le champ et les boutons, il manque également le curseur sur les boutons → 8 px, `SystemMouseCursors.click`
- la mise à jour visuelle reste un peu lente, et surtout quand on fait plusieurs clics → sauvegarde regroupée 400 ms après le dernier clic (C1)
- dans la liste des joueurs, les billes de nombre de sessions, jetons et bonus doivent être grisées quand = 0 → fait, ajouté au périmètre
- L10 ok
