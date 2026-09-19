# Recette — L05

Faite par Bastien le 2026-09-19.

- passer par le générateur PDF à chaque modification est long ; proposer une expérience rapide en modification, puis un bouton pour l'aperçu PDF → aperçu rapide Flutter par défaut, aperçu PDF sur demande (C15)
- en mm il faut autoriser les virgules → longueurs en `double`, virgule ou point ; type des champs vérifié sur une copie de la base réelle (C3)
- l'image n'est pas affichée au chargement → les champs étaient créés avant la fin du chargement ; recréés à chaque chargement terminé
- la largeur de carte est conservée mais mal réaffichée → même cause, corrigé par le fix précédent
- le sélecteur de couleur lève « No MaterialLocalizations found » → `flex_color_picker` 4 est bâti sur `material_ui` ; rétrogradé en 3.8 (C11), question transversale au pilotage
- la notification d'enregistrement doit disparaître plus vite et pouvoir être fermée → 2 s, croix
- ajouter la suppression des joueurs dans le formulaire d'événement → bouton rouge avec confirmation dans le bloc protection (C16)
- séparer le numéro du QR code dans le modèle joueur, afficher le numéro partout où le QR code l'était → `Player.number`, migration à l'ouverture (C14)
- générateur de cartes bon, L05 complet
