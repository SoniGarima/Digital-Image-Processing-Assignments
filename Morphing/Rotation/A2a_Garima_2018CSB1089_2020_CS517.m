function outx=A2a_Garima_2018CSB1089_2020_CS517(fname_inp1,fname_inp2,angle,tpts,afnTM,fname_out,toshow)
    W=imread(fname_inp1);
%     W=rgb2gray(W);
    [m,n]=size(W);
    d=ceil(sqrt(m^2+n^2));
    in=uint8(zeros(d,d));
    My_cell=cell(15,1);
    for i=floor((d-m)/2)+1:floor((d-m)/2)+m
        for j=floor((d-n)/2)+1:floor((d-n)/2)+n
            in(i,j)=W(i-floor((d-m)/2),j-floor((d-n)/2));
        end
    end 
    I=[1 0 0;0 1 0;0 0 1];
    theta=angle*pi/180;
    aff_matrix=[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
    for g=0:14
        alpha=(g)/14;
        out=uint8(zeros(d,d));
        my_mat=(1-alpha).*I+alpha.*aff_matrix;
        c=my_mat(1,1);
        s=my_mat(2,1);
    for i=1:d
        for j=1:d
            xn=floor(d/2+(i-(d/2))*c+(j-(d/2))*s);
            yn=floor(d/2+(j-(d/2))*c-(i-(d/2))*s);
            xn=min(d,xn);
            xn=max(1,xn);
            yn=min(d,yn);
            yn=max(1,yn);
            out(i,j)=in(xn,yn);
        end
    end
    My_cell{g+1}=out;
    end
    if(toshow==1)
        for o=1:15
            subplot(3,5,o);
            imshow(My_cell{o});
%              imwrite(My_cell{o},sprintf('out%s.tif',o));
        end
    end
FileName = fname_out;
for k = 1:numel(My_cell)

    if k ==1
        imwrite(My_cell{k},FileName,'gif','LoopCount',Inf,'DelayTime',.2);
    else
        imwrite(My_cell{k},FileName,'gif','WriteMode','append','DelayTime',.2);
    end

end

end