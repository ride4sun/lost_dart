//Copyright (C) 2012-2013 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of lost_dart;

/**
 * Factory of Objects.
 */
class ObjectFactory {

  /**
   * Create [id] instance of class in [Container] desribed  by [ObjectDefinition].
   */
  dynamic create(String id, Container container, ObjectDefinition od) {
    if (od.factory != null) {
      // Use Factory Function to make an instance
      dynamic result = od.factory();
      // Set fields if necessary
      if (od.props != null) {
        mirrors.InstanceMirror instanceMirror = mirrors.reflect(result);
        _setFields(container, instanceMirror, od.props);
      }
      return result;
    } else if (od.clazz != null) {
      // Clazz presents
      // Use Factory Class to make an instance
      mirrors.InstanceMirror instanceMirror = od.clazz.newInstance(od.constructorName, _resolveConstructorArguments(container, od.constructorArgs));
      // Set fields if necessary
      if (od.props.isNotEmpty) {
        _setFields(container, instanceMirror, od.props);
      }
      // Return an instance
      return instanceMirror.reflectee;
    }
    // We have no way to create an instance of class
    throw new InstanceCreationException(id);
  }
  
  /**
   * Set fields in [instanceMirror] from [props] map.
   */
  void _setFields(Container container, mirrors.InstanceMirror instanceMirror, Map props) {
    // Apply paramters
    for (String name in props.keys) {
      dynamic propValue = null;
      Argument arg = props[name];
      if (arg is TypeArgument) {
        propValue = container.get(arg.value);
      } else if (arg is RefArgument) {
        propValue = container.getAs(arg.value);
      } else if (arg is ConstArgument) {
        propValue = arg.value;
      } else {
        throw new UnsupportArgumentTypeException(arg);
      }
      instanceMirror.setField(new Symbol(name), propValue);
    }
  }
  
  /**
   * Resolve list of constructor arguments and return list of resolver arguments.
   */
  List _resolveConstructorArguments(Container container, List args) {
    List result = [];
    for (var arg in args) {
      if (arg is TypeArgument) {
        result.add(container.get((arg as TypeArgument).value));
      } else if (arg is RefArgument) {
        result.add(container.getAs((arg as RefArgument).value));
      } else if (arg is ConstArgument) {
        result.add((arg as ConstArgument).value);
      } else {
        throw new UnsupportArgumentTypeException(arg);
      }
    }
    return result;
  }
}