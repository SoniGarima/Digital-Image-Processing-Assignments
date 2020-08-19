q_mtx =     ([16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99]);
        
q_mtx2=([17	18	24	47	99	99	99	99;
        18	21	26	66	99	99	99	99;
        24	26	56	99	99	99	99	99;
        47	66	99	99	99	99	99	99;
        99	99	99	99	99	99	99	99;
        99	99	99	99	99	99	99	99;
        99	99	99	99	99	99	99	99;
        99	99	99	99	99	99	99	99]);  
   My_cell=cell(8,1);
    for g=1:8
        My_cell{g}=imread("tr"+string(g)+".jpeg");
    end
    FileName = "blur_to_sharp.gif";
    for k = 1:numel(My_cell)
        if k ==1
            imwrite(My_cell{k},FileName,'gif','LoopCount',Inf,'DelayTime',1);
        else
            imwrite(My_cell{k},FileName,'gif','WriteMode','append','DelayTime',1);
        end
 
    end