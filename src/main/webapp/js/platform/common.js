$.extend({
    // 合并两个json对象， 属性重合时， 以第二个对象为准
    mergeJsonObject: function (obj1, obj2) {
        var result = {};
        if (obj1) {
            for (var attr in obj1) {
                result[attr] = obj1[attr];
            }
        }
        if (obj2) {
            for (var attr in obj2) {
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
            async: false,
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
        if (options) {
            $('#' + containerId).combobox(options);
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
            valueField: 'id',
            textField: 'text'
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
        if (initText) {
            var init = {};
            init.code = initCode;
            init.text = initText;
            data.push(init);
        }

        if (loadEnum) {
            var keys = Object.keys(loadEnum);
            for (var i = 0; i < keys.length; i++) {
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

            if (extOptions) {
                return $.mergeJsonObject(result, extOptions);
            }

            return result;
        }
    },
    createIFrameContainer: function (containerId, url) {
        var $container = $('<div id="' + containerId + '" style="width:100%;height:100%;border:0; overflow:hidden;"></div>');
        var $iFrame = $('<iframe src="' + url + '" style="width:100%;height:100%;border:0;scrolling="auto"" ></iframe>');
        var _html = "<div id='loading' style='position:absolute;left:0;width:100%;height:100%;top:0;background:#F4F4F4;opacity:0.7;filter:alpha(opacity=80);'>\
                     <div style='position:absolute;  cursor1:wait;left:45%;top:45%;width:auto;height:16px;padding:12px 5px 10px 30px;\
                     background:#fff url(/js/easyui/themes/default/images/loading.gif) no-repeat scroll 5px 10px;border:2px solid #ccc;color:#000;'>\
                     正在加载，请等待...\
                     </div></div>";
        var $loading = $(_html);
        $container.append($iFrame);
        $container.append($loading);
        $loading.width = $iFrame.width;
        $loading.height = $iFrame.height;
        $iFrame.load(function () {
            $loading.remove();
        });

        return $container;
    },
    _log: function (str) {
        if (console) {
            console.log(str);
        }
    }
});

$.fn.extend({
    openWindow: function (containerId, url, width, height, title, extOptions) {

        if (!width) {
            width = 750;
        }
        if (!height) {
            height = 570;
        }

        // 修正window的高度和宽度
        var _width = width > this.width() ? this.width() - 20 : width;
        var _height = height > this.height() ? this.height() - 20 : height;

        if (_width < width) {
            $._log("修正宽度为：" + _width);
        }
        if (_height < height) {
            $._log("修正高度为:" + _height);
        }

        var $document = $($(this)[0].document);
        var $container = $document.find("#" + containerId);
        if ($container.length == 0) {
            $container = $.createIFrameContainer(containerId, url);
            $document.find("body").append($container);
        } else {
            $container.find("iframe").attr('src', url);
        }
        var options = {
            minimizable: false,
            collapsible: false,
            zIndex: 90000,
            onClose: function () {
                $container.window('destroy');
            }
        };
        options.title = title;
        options.width = _width;
        options.height = _height;
        var $iframe = $container.find('iframe');
        var $loadingDiv = $container.find('div');

        if (extOptions) {
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
        if (containerId && window) {
            var $document = $(this).getDocument(window);
            var $container = $document.find("#" + containerId);
            if ($container.length > 0) {
                try {
                    // 为了触发onClose事件
                    window[0].$("#" + containerId).window('close');
                    window[0].$("#" + containerId).window('destroy');
                } catch (error) {
                    alert(error);
                }

            } else if (window[0].parent != window[0].self) {
                $(this).close(containerId, $(window[0].parent));
            } else {
                alert("没有可关闭的窗口");
            }
        }
    },
    getDocument: function (window) {
        if (!window) {
            return $(this[0].document);
        }
        return $($(window)[0].document);
    },
    _confirm: function (content, success, title, failed) {
        if (!title) {
            title = "警告";
        }
        $.messager.confirm(title, content, function (r) {
            if (r) {
                if ($.isFunction(success)) {
                    success();
                }
            } else {
                if ($.isFunction(failed)) {
                    failed();
                }
            }
        })
    },
    _alert: function (content, title) {
        if (!title) {
            title = "警告";
        }
        $.messager.alert(title, content);
    },
    _openTab: function (containerId, url, title, containerWindow, ext) {
        if (!url || url == undefined) {
            return;
        }
        if(!ext){
            ext = {};
        }
        if (!title || title == undefined) {
            return;
        }
        if (title.length > 8) {
            title = title.substring(0, 8) + "...";
        }

        if (!containerWindow || containerWindow == undefined) {
            containerWindow = window;
        }

        var $container = containerWindow.$("#" + containerId);

        if ($container.tabs('exists', title)) {
            $container.tabs('select', title);
            return;
        }
        var content = $.createIFrameContainer('default', url);
        var options = $.extend({}, {
            title: title,
            content: content,
            closable: true
        }, ext);
        $container.tabs('add', options);
    },
    _addGridChanges: function (girdId, prefix, type) {

        var grid = $("#" + girdId);
        var rows = grid.datagrid('getRows');
        for (var i = 0; i < rows.length; i++) {
            var rowIndex = grid.datagrid('getRowIndex', rows[i]);
            grid.datagrid('endEdit', rowIndex);
        }

        if (prefix && prefix != undefined) {
            var changes = grid.datagrid('getChanges', type);
            for (var j = 0; j < changes.length; j++) {
                var record = changes[j];
                for (var attr in record) {
                    var name = prefix + "[" + j + "]." + attr;
                    var input = $("<input type='hidden' name='" + name + "' value='" + record[attr] + "'  />");
                    $(this).append(input);
                }
            }
        }
    },
    _showLoading: function (id) {
        if (!id) {
            id = "loading";
        }
        var _html = "<div id='" + id + "' style='position:absolute;left:0;width:100%;height:100%;top:0;z-index:99999;background:#F4F4F4;opacity:0.8;filter:alpha(opacity=80);'>\
                     <div style='position:absolute;  cursor1:wait;left:45%;top:45%;width:auto;height:16px;padding:12px 5px 10px 30px;\
                     background:#fff url(/js/easyui/themes/default/images/loading.gif) no-repeat scroll 5px 10px;border:2px solid #ccc;color:#000;'>\
                     正在处理，请等待...\
                     </div></div>";
        var $loading = $(_html);
        var $body = window.$("body");
        $body.append($loading);
        $loading.css({
            position: 'absolute',
            left: 0,
            width: '100%',
            top: 0,
            height: '100%'
        });
        return $loading;
    },

    _block: function (mills) {
        $.ajax("/sleep.do", {
            async: false,
            timeout: mills,
            data: {
                mills: mills
            }
        });
    }
});