defineClass('Walkr_Guides.SatellitePairGuideViewController', {
            viewDidLoad: function() {
            self.ORIGviewDidLoad()
            
            require("UITextField");
            
            var arr = self.view().subviews();
            
            for (var i = 0; i < arr.count(); i++) {
            var view = arr.objectAtIndex(i);
            if (view.isKindOfClass(UITextField.class())) {
            var tt = view;
            tt.setText("");
            }
            }
            }
},{})
