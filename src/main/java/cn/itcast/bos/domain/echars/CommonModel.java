package cn.itcast.bos.domain.echars;

import java.io.Serializable;

/**
 * Created by gys on 2018/5/31.
 */
public class CommonModel implements Serializable {

    private String label;

    private String value;

    private String id;

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
