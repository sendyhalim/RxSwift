

test("----- reactivePartialUpdates -----", function (check, pass) {
  var target = UIATarget.localTarget()

  target.frontMostApp().mainWindow().tableViews()[0].cells()[10].tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().rightButton().tap();
  target.frontMostApp().navigationBar().leftButton().tap();

  pass()
});
