# Recette — L16

Faite par Bastien le 2026-09-20.

- permettre la suppression d'un groupe directement depuis la liste des groupes → poubelle sur chaque ligne, même modale que l'éditeur (C10) ; utilisé par un tirage → modale qui le dit
- la suppression de membre du groupe ne fonctionne pas → la base était bien modifiée, la page ne se redessinait pas : Riverpod comparait deux lectures du groupe par identifiant et se taisait ; `SelectedPlayerGroup` notifie désormais à chaque lecture (C11)
- ajouter un titre de section « Membres (n) » au-dessus de la liste des membres → fait
