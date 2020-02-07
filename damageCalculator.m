function hitPoints = damageCalculator(attack,defense,damage)
attack = attack * .1;
defense = defense * .1;
hitPoints = damage * (1 + attack) - defense * damage;