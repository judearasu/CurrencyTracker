function ViewController(root_element, controller) {
  controller.root = root_element;

  for( key in controller )
    if( typeof controller[key] == 'function' )
      controller[key] = controller[key].bind(controller);
  
  controller.initialize();

  return controller;
};