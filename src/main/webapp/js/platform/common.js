$.extend({
    // 合并两个json对象， 属性重合时， 以第二个对象为准
    mergeJsonObject: function (obj1, obj2) {
        var result = {};
        if(obj1){
            for(var attr in obj1){
                result[attr] = obj1[attr];
            }
        }
        if(obj2){
            for(var attr in obj2){
                result[attr] = obj2[attr];
            }
        }

        return result;
    },
    loadEnum: function (_id, idColumn, valueColumn, tableName, condition) {
        var result = null;
        $.ajax("/base/loadEnum", {
            data: {
                id: _id
            },
            async : false,
            success: function (data) {
                result = data;
            },
            error: function (jqXHR) {
                alert(JSON.stringify(jqXHR, null, 4));
            }

        });
        return result;
    },
    enumCombobox: function (containerId, enumType, initCode, initText) {

        var options = $.enumComboboxOptions(enumType, initCode, initText);
        if(options){
            $('#'+containerId).combobox(options);
        }


    },
    /**
     *  根据一个enumType获取一个Combobox的配置信息
     * @param enumType 枚举类型
     * @param initCode 初始化值
     * @param initText 初始化显示
     * @param extOptions 其它配置
     * @returns {*}
     */
    enumComboboxOptions: function (enumType, initCode, initText, extOptions) {
        var loadEnum = $.loadEnum(enumType);
        var data = [];
        if(initText){
            var init = {};
            init.code = initCode;
            init.text = initText;
            data.push(init);
        }

        if(loadEnum){
            var keys = Object.keys(loadEnum);
            for (var i = 0; i < keys.length; i++){
                var json = {};
                var _key = keys[i];
                json.code = _key;
                json.text = loadEnum[_key];
                data.push(json);
            }

            var result = {};

            result.data = data;
            result.valueField = 'code';
            result.textField = 'text';

            if(extOptions){
                return $.mergeJsonObject(result, extOptions);
            }

            return result;
        }
    },
    createIFrameContainer: function (containerId, url) {
        var $container = $('<div class="easyui-window" id="'+containerId+'"></div>');
        var $iFrame = $('<iframe src="'+url+'" style="width:100%;height:100%;border:0;" ></iframe>');
        $container.append($iFrame);
        return $container;
    }
});

$.fn.extend({
    openWindow: function (containerId, url, width, height, title ,extOptions) {

        var $document = $($(this)[0].document);
        var $container = $document.find("#" + containerId);
        if($container.length == 0){
            $container = $.createIFrameContainer(containerId, url);
            $document.find("body").append($container);
        }else{
            $container.find("iframe").attr('src', url);
        }
        var options = {
            minimizable: false,
            collapsible: false,
            onClose: function () {
                $container.window('destroy');
            }
        };
        options.title = title;
        options.width = width;
        options.height = height;
        if(extOptions){
            $container.window($.mergeJsonObject(options, extOptions));
            return;
        }
        $container.window(options);
        $container.window('open');
    },
    closeWindow: function (containerId) {
        $(this).close(containerId, this);
    },
    close: function (containerId, window) {
        if(containerId && window){
            var $document = $(this).getDocument(window);
            var $container = $document.find("#" + containerId);
            if($container.length > 0){
                try{
                    // 为了触发onClose事件
                    window[0].$("#" + containerId).window('close');
                    window[0].$("#" + containerId).window('destroy');
                }catch (error){
                    alert(error);
                }

            }else if(window[0].parent != window[0].self) {
                $(this).close(containerId, $(window[0].parent));
            }else{
                alert("没有可关闭的窗口");
            }
        }
    },
    getDocument: function (window) {
        if(!window){
            return $(this[0].document);
        }
        return $($(window)[0].document);
    }
});