import 'package:lost_dart/lost_dart.dart';

/**
 * Asbtract class Weapon
 */
abstract class Weapon
{
  /**
   * Hit the [target].
   */
  String Hit(String target);
}

/**
 * Sword Weapon
 */
class Sword implements Weapon 
{
  /**
   * Hit the [target].
   */
  String Hit(String target) 
  {
    return "Slice " + target + " in half";
  }
}

/**
 * Dagger Weapon
 */
class Dagger implements Weapon 
{
  /**
   * Hit the [target].
   */
  String Hit(String target) 
  {
    return "Stab " + target + " to death";
  }
}

/**
 * Samurai fully equipped.
 */
class Samurai 
{
  List<Weapon> allWeapons;

  Samurai(List<Weapon> this.allWeapons); 

  /**
   * Just attack the [target].
   */
  void Attack(String target) 
  {
    for (Weapon weapon in this.allWeapons) {
      print(weapon.Hit(target));
    }
  }
}

void main() {
  Container container = new Container();
  
  // Bind Sword
  container.bind(Sword);
  // Bind Sword
  container.bind(Dagger);
  // Bind weapons as list
  container.bindAs("weapons").toFactory(() {
    return [container.get(Sword), container.get(Dagger)];
  });
  
  
  // Bind Samurai with list of weapons
  container.bind(Samurai).addConstructorRefArg("weapons");
  
  
  // Get samurai 
  Samurai samurai = container.get(Samurai);
  // Atack
  samurai.Attack("your enemy");
}
