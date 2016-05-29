responsive.init = (function(){

    var $typeImage = $("img[data-path]");
    var resizeType = responsive.getResizeType();

    $typeImage.each(function(){
        var self = this, $self = $(this);
        self.path = $self.data('path');
        self.ext = $self.data('ext');
        self.typeArr = $self.data('type').split(',');
        for (var i=1;i<4;i++){
            var type = self.typeArr[i-1];
            self['t'+i] = self.path + '_' + type + '.' + self.ext;
        }
        this.src = this[resizeType];
    });
    responsive.resize();

    responsive.addChangedType(function(type, size){
        $typeImage.each(function(){
            if(this[type] !== undefined){
                this.src =  this[type];
            }

        });
    });


}());