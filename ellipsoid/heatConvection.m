%液体内部的热对流过程
function heatConvection
global next_tcell;  %更新状态的元胞
global length;      %元胞体的长宽高
global width;
global height;
global P;           %热对流元胞移动概率
global humanX_start;global humanX_end;  %人体
global humanY_start;global humanY_end;
global humanZ_start;global humanZ_end;
global tcell_type; global ishuman;
 %热对流的概率交换过程
      for x1=2:length-1
        for y1=2:width-1
            for z1=2:height-1
                %避开人体
%                  if(x1<humanX_start-1||x1>humanX_end+1||y1<humanY_start-1||y1>humanY_end+1||z1<humanZ_start-1||z1>humanZ_end+1)
                    if(tcell_type(x1,y1,z1)==ishuman ||tcell_type(x1+1,y1,z1)==ishuman||tcell_type(x1-1,y1,z1)==ishuman||...
                         tcell_type(x1,y1+1,z1)==ishuman||tcell_type(x1,y1-1,z1)==ishuman||...
                         tcell_type(x1,y1,z1+1)==ishuman||tcell_type(x1,y1,z1-1)==ishuman)
                      continue;
                    else
                    %概率和边界条件
                    if (rand<P && z1<height-1 && y1<width-1 && x1<length-1 &&x1>2 &&y1>2 &&z1>2)  
                        if(rand<P&& next_tcell(x1,y1,z1)>next_tcell(x1,y1,z1+1))
                        temp=next_tcell(x1,y1,z1+1);
                        next_tcell(x1,y1,z1+1)=next_tcell(x1,y1,z1);
                        next_tcell(x1,y1,z1)=temp;
                        end
                        if(rand<P&& next_tcell(x1,y1,z1)>next_tcell(x1,y1+1,z1))   %水平位移前对流
                        temp=next_tcell(x1,y1+1,z1);
                        next_tcell(x1,y1+1,z1)=next_tcell(x1,y1,z1);
                        next_tcell(x1,y1,z1)=temp;
                        end
                        if(rand<P&&next_tcell(x1,y1,z1)>next_tcell(x1,y1-1,z1))   %水平位移后对流
                        temp=next_tcell(x1,y1-1,z1);
                        next_tcell(x1,y1-1,z1)=next_tcell(x1,y1,z1);
                        next_tcell(x1,y1,z1)=temp;
                        end
                        if(rand<P&&next_tcell(x1,y1,z1)>next_tcell(x1+1,y1,z1))   %水平位移右对流
                        temp=next_tcell(x1+1,y1,z1);
                        next_tcell(x1+1,y1,z1)=next_tcell(x1,y1,z1);
                        next_tcell(x1,y1,z1)=temp;
                        end
                        if(rand<P&&next_tcell(x1,y1,z1)>next_tcell(x1-1,y1,z1))   %水平位移左对流
                        temp=next_tcell(x1-1,y1,z1);
                        next_tcell(x1-1,y1,z1)=next_tcell(x1,y1,z1);
                        next_tcell(x1,y1,z1)=temp;
                        end
                    end
                end
            end
        end
      end
end