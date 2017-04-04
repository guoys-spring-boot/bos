$.extend({
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
            $('#'+containerId).combobox({
                data : data,
                valueField:'code',
                textField:'text'
            });

        }
    }
});