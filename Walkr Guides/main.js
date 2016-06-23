defineClass('Walkr_Guides.SatellitePairGuideViewController', {
            viewDidLoad: function() {
            self.ORIGviewDidLoad()
            
            console.log("123")
            
            var views = self.view().subviews()
            var index = 0
            console.log('views count:' + views.count())
            for(index = 0; index<views.count(); index++){
            
            var view = views.objectAtIndex(index)
            if (view.isKindOfClass(require('UIButton').class())) {
            console.log('this is btn')
            var title = view.currentTitle()
            console.log('title:' + title.toJS())
            if (title.isEqualToString("查询匹配")){
                view.setTitle_forState("回到游戏", 0)
                view.removeTarget_action_forControlEvents(self, 'onCheck', 64)
                view.addTarget_action_forControlEvents(self,'onGoBackToGame',64)
            }
            }
            }
            },
            
            
            onGoBackToGame: function()
            {
                console.log('aaaa')
                var urls = require('NSURL').init("walkrgame://")
            
                require('UIApplication').sharedApplication().openURL(urls)
            }
},{})
