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
     *  使用url加载enumbox数据
     * @param containerId
     * @param url
     * @param initCode
     * @param initText
     */
    enumComboboxFromUrl: function (containerId, url) {
        var options = {
            url: url,
            valueField:'id',
            textField:'text'
        };
        $("#" + containerId).combobox(options);
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
        var $iFrame = $('<iframe src="'+url+'" style="width:100%;height:100%;border:0;display: none" ></iframe>');
        var $loading = $('<div style="align-items: center;width: 100%; height: 100%" >loading...</div>');
        $container.append($iFrame);
        $container.append($loading);
        return $container;
    },
    _log : function (str) {
        if(console){
            console.log(str);
        }
    }
});

$.fn.extend({
    openWindow: function (containerId, url, width, height, title ,extOptions) {

        if(!width){
            width = 750;
        }
        if(!height){
            height = 570;
        }

        // 修正window的高度和宽度
        var _width = width > this.width() ? this.width() -20 : width;
        var _height = height > this.height() ? this.height() -20 : height;

        if(_width < width){
            $._log("修正宽度为：" + _width);
        }
        if(_height < height){
            $._log("修正高度为:" + _height);
        }

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
            zIndex:90000,
            onClose: function () {
                $container.window('destroy');
            }
        };
        options.title = title;
        options.width = _width;
        options.height = _height;
        var $iframe = $container.find('iframe');
        var $loadingDiv = $container.find('div');
        if(extOptions){
            $container.window($.mergeJsonObject(options, extOptions));
            $iframe.load(function () {
                $iframe.show("fast", "linear");
                $loadingDiv.hide();
            });
            return;
        }
        $container.window(options);
        $container.window('open');
        $container.load(function () {
            $iframe.show("fast", "linear");
            $loadingDiv.hide();
        })


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
    },
    _confirm: function(content, success, title){
        if(!title){
            title = "警告";
        }
        $.messager.confirm(title, content, function (r) {
            if(r && $.isFunction(success)){
                success();
            }
        })
    },
    _alert: function (content, title) {
        if(!title){
            title = "警告";
        }
        $.messager.alert(title, content);
    },
    _openTab: function(containerId, url, title, containerWindow){
        if(!url || url == undefined){
            return;
        }
        if(!title || title == undefined){
            return;
        }
        if(title.length > 5){
            title = title.substring(0, 5) + "...";
        }

        if(!containerWindow || containerWindow == undefined){
            containerWindow = this;
        }

        var $container = $(containerWindow)[0].$("#" + containerId);

        if($container.tabs('exists', title)){
            $container.tabs('select', title);
            return;
        }

        var content = '<div style="width:100%;height:100%;overflow:hidden;">'
            + '<iframe src="'
            + url
            + '" scrolling="auto" style="width:100%;height:100%;border:0;" ></iframe></div>';

        $container.tabs('add', {
            title : title,
            content : content,
            closable : true
        });
    },
    _addGridChanges: function (girdId, prefix, type) {

        var grid = $("#" + girdId);
        var rows = grid.datagrid('getRows');
        for (var i = 0; i < rows.length; i++){
            var rowIndex = grid.datagrid('getRowIndex', rows[i]);
            grid.datagrid('endEdit', rowIndex);
        }

        if(prefix && prefix != undefined){
            var changes = grid.datagrid('getChanges', type);
            for(var j = 0; j< changes.length; j++){
                var record = changes[j];
                for (var attr in record){
                    var name =  prefix + "["+ j + "]." + attr;
                    var input = $("<input type='hidden' name='"+name+"' value='"+record[attr]+"'  />");
                    $(this).append(input);
                }
            }
        }
    }
});