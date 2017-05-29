package cn.itcast.bos.web.upload;

import java.math.BigDecimal;

/**
 * Created by gys on 2017/5/26.
 */
public class UploadStatus {

    private long size;

    private long alreayRead;

    private int items; //第几个


    public UploadStatus(long size, long alreayRead, int items){
        this.size = size;
        this.alreayRead = alreayRead;
        this. items = items;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public long getAlreayRead() {
        return alreayRead;
    }

    public void setAlreayRead(long alreayRead) {
        this.alreayRead = alreayRead;
    }

    public int getItems() {
        return items;
    }

    public void setItems(int items) {
        this.items = items;
    }

    public double getPercent() {
        if(this.size == 0){
            return 0d;
        }

        BigDecimal divide = new BigDecimal(Long.toString(this.alreayRead))
                .divide(new BigDecimal(Long.toString(this.size)), 2,  BigDecimal.ROUND_HALF_EVEN);

        //System.out.println(this);
        //System.out.println(divide.doubleValue());
        return divide.doubleValue();
    }

    @Override
    public String toString() {
        return "UploadStatus{" +
                "size=" + size +
                ", alreayRead=" + alreayRead +
                ", items=" + items +
                '}';
    }
}
