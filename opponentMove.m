function [damage,attackName] = opponentMove(OAttack,Defense,OAccuracy)
load('OStats.mat')
num = randi([1,6]); % generates a random number that will choose one of the 6 attacks
random = randi([-5,10]);
if random <= OAccuracy;   % determines whether or not the attack will miss
    miss_chance = 1;
else
    miss_chance = 0;
end
switch num  % chooses an attack at random and calculates the damage.
    case 1
        damage = damageCalculator(OAttack,Defense,randi([5,7])); % calculates damage 
        attackName = 'Punch';
    case 2
        damage = damageCalculator(OAttack,Defense,randi([1,10])) * miss_chance;
        attackName = 'Kick';
    case 3
        damage = 0;
        attackName = 'Homework';
    case 4
        damage = damageCalculator(OAttack,Defense,15) * miss_chance;
        attackName = 'Body Slam';
    case 5
        damage = damageCalculator(OAttack,Defense,3);
        attackName = 'Pop Quiz';
    case 6
        damage = 0;
        attackName = 'Sick Day';
end

