defineClass('Walkr_Guides.SatellitePairGuideViewController', {
            viewDidLoad: function() {
            self.ORIGviewDidLoad()
            
            self.myPrint("123123")
            
            require('UIAlertController, UIAlertAction')
            var ws = __weak(self)
            var alert = UIAlertController.alertControllerWithTitle_message_preferredStyle("是否退出此次编辑?","",1)
            var cancel = UIAlertAction.actionWithTitle_style_handler("否", 1, null)
            var ok = UIAlertAction.actionWithTitle_style_handler("是", 0, block('UIAlertAction',
                                                                               function(action){
                                                                               
                                                                               }))
            alert.addAction(cancel)
            alert.addAction(ok)
            self.presentViewController_animated_completion(alert, YES, null)
            },
            
            myPrint: function(inpuStr){
                console.log(inpuStr)
            }
},{})
