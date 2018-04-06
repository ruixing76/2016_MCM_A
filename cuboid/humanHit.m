%人的动作拍打的强制对流模型
function humanHit
global next_tcell;  %更新状态的元胞
global length;global width;global height;      %元胞体的长宽高
global P_hit;       %人做动作的概率

for i1=3:length-3
    for j1=3:width-3
        for k1=3:height-3
            temp=NaN;temp_x=i1;temp_y=j1;temp_z=k1;
            if(rand <P_hit)
                %寻找摩尔邻居中温度最低的
                for i2=i1-1:i1+1
                    for j2=j1-1:j1+1
                        for k3=k1-1:k1+1
                            if(next_tcell(i2,j2,k3)<temp)
                                temp=next_tcell(i2,j2,k3);
                                temp_x=i2;temp_y=j2;temp_z=k3;
                            end
                        end
                    end
                end
            %交换找到的元胞
            temp=next_tcell(i1,j1,k1);
            next_tcell(i1,j1,k1)=next_tcell(temp_x,temp_y,temp_z);
            next_tcell(temp_x,temp_y,temp_z)=temp;
            end
            
        end
    end 
end

end
