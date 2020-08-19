function A2b_Garima_2018csb1089_2020_CS517(fname_inp1, fname_inp2, tpts, fname_out, toshow)
     A=imread(fname_inp1);
      B=imread(fname_inp2);
      Q=tpts(:,1:2);
      P=tpts(:,3:4);
%       A=imread("A.tif");
%       B=imread("B.tif");
%     X=[179;196;216;204;255;300;321;336;311;257;235;279;259;261;230;304;252;140;381;1;512;1;512];
%      Y=[211;226;232;207;236;229;220;206;198;372;353;352;411;433;426;425;490;292;296;1;512;512;1];
%      Q=[Y X];
%      P=[128 220;152 234;181 229;154 205;212 286;241 232;271 238;294 225;268 209;208 361;191 354;225 351;210 399;211 445;164 406;250 407;210 507;89 291;323 280;1 1;512 512;1 512;512 1];
%      p=P(:,1);
%      P(:,1)=P(:,2);
%      P(:,2)=p;
      E=(Q+P)./2;
    Bd=delaunayTriangulation(Q);
    bd=Bd.ConnectivityList;
    Ad=delaunayTriangulation(P);
    ad=Ad.ConnectivityList;
    Ed=delaunayTriangulation(E);
    ed=Ed.ConnectivityList;
    [m,~]=size(bd);
    [n,~]=size(ad);
    C1=uint8(zeros(512,512));
    D1=uint8(zeros(512,512));
    C2=uint8(zeros(512,512));
    D2=uint8(zeros(512,512));
    trb=zeros(m*3,3);
    tra=zeros(n*3,3);
    intr=1;
    for i=1:m
        p1=bd(i,1);
        p2=bd(i,2);
        p3=bd(i,3);
        y=[E(p1,1) E(p2,1) E(p3,1);E(p1,2) E(p2,2) E(p3,2);1 1 1];
        x=[Q(p1,1) Q(p2,1) Q(p3,1);Q(p1,2) Q(p2,2) Q(p3,2);1 1 1];
        a=y/x;
        trb(intr:intr+2,:)=a;
        intr=intr+3;
    end
    for x1=1:512
        for y1=1:512
            k=pointLocation(triangulation(bd,Q),x1,y1);
            trm_=trb(3*k-2:3*k,:);
            trr_=round(.5+trm_*[x1;y1;1]);
            trr_(1)=max(1,min(512,(trr_(1))));
            trr_(2)=max(1,min(512,(trr_(2))));
            C1(trr_(1),trr_(2))=B(x1,y1);
        end
    end
    intr=1;
    for i=1:n
        p1=ad(i,1);
        p2=ad(i,2);
        p3=ad(i,3);
        y=[E(p1,1) E(p2,1) E(p3,1);E(p1,2) E(p2,2) E(p3,2);1 1 1];
        x=[P(p1,1) P(p2,1) P(p3,1);P(p1,2) P(p2,2) P(p3,2);1 1 1];
        a=y/x;
        tra(intr:intr+2,:)=a;
        intr=intr+3;
    end
    for x1=1:512
        for y1=1:512
            k=pointLocation(triangulation(ad,P),x1,y1);
            trm_=tra(3*k-2:3*k,:);
            trr_=round(.5+trm_*[x1;y1;1]);
            trr_(1)=max(1,min(512,(trr_(1))));
            trr_(2)=max(1,min(512,(trr_(2))));
            D1(trr_(1),trr_(2))=A(x1,y1);
        end
    end
    trb=zeros(m*3,3);
    tra=zeros(n*3,3);
    disp(tra);
    intr=1;
    for i=1:m
        p1=bd(i,1);
        p2=bd(i,2);
        p3=bd(i,3);
        y=[E(p1,1) E(p2,1) E(p3,1);E(p1,2) E(p2,2) E(p3,2);1 1 1];
        x=[Q(p1,1) Q(p2,1) Q(p3,1);Q(p1,2) Q(p2,2) Q(p3,2);1 1 1];
        z=[P(p1,1) P(p2,1) P(p3,1);P(p1,2) P(p2,2) P(p3,2);1 1 1];
        a=x*inv(y);
        ui=z*inv(y);
        trb(intr:intr+2,:)=a;
        tra(intr:intr+2,:)=ui;
        intr=intr+3;
    end
    for x1=1:512
        for y1=1:512
            k=pointLocation(triangulation(ed,E),x1,y1);
            trm_1=trb(3*k-2:3*k,:);
            trm_2=tra(3*k-2:3*k,:);
            trr_1=round(.5+trm_1*[x1;y1;1]);
            trr_2=round(.5+trm_2*[x1;y1;1]);
            trr_1(1)=max(1,min(512,(trr_1(1))));
            trr_1(2)=max(1,min(512,(trr_1(2))));
            trr_2(1)=max(1,min(512,(trr_2(1))));
            trr_2(2)=max(1,min(512,(trr_2(2))));
            C2(x1,y1,:)=B(trr_1(1),trr_1(2),:);
            D2(x1,y1,:)=A(trr_2(1),trr_2(2),:);
        end
    end
    for i=1:512
        for j=1:512
            if(C1(i,j,:)<100)
                C1(i,j,:)=C2(i,j,:);
            end
            if(D1(i,j,:)<100)
                D1(i,j,:)=D2(i,j,:);
            end
        end
    end
    My_cell=cell(21,1);
    for g=0:20
        alpha=g/20;
        Y_out=alpha.*C1+(1-alpha).*D1;
        My_cell{g+1}=Y_out;
    end
    FileName = fname_out;
    for k = 1:numel(My_cell)
        if k ==1
            imwrite(My_cell{k},FileName,'gif','LoopCount',Inf,'DelayTime',.3);
        else
            imwrite(My_cell{k},FileName,'gif','WriteMode','append','DelayTime',.3);
        end
 
    end
    if(toshow)
        for t=1:21
            subplot(5,5,t);
            imshow(My_cell{t});
        end
    end    
 end