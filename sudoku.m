

board_lib = {'000000000000000000000000000000000000000000000000000000000000000000000000000000000',...
    '004300209005009001070060043006002087190007400050083000600000105003508690042910300',...
    '004083002051004300000096710120800006040000500830607900060309040007000205090050803',...
    '000060280709001000860320074900040510007190340003006002002970000300800905500000021',...
    '004300000890200670700900050500008140070032060600001308001750900005040012980006005',...
    '008070100120090054000003020604010089530780010009062300080040607007506000400800002'
    };
answer_lib = {'000000000000000000000000000000000000000000000000000000000000000000000000000000000',...
    '864371259325849761971265843436192587198657432257483916689734125713528694542916378',...
    '974183652651274389283596714129835476746912538835647921568329147317468295492751863',...
    '431567289729481653865329174986243517257198346143756892612975438374812965598634721',...
    '254367891893215674716984253532698147178432569649571328421753986365849712987126435',...
    '958274163123698754746153928674315289532789416819462375285941637397526841461837592'
    };

board_idx = randi([2,length(board_lib)])
org_board = board_lib{board_idx};



while check_correct(org_board,board_lib,answer_lib,board_idx) == 0
    %main control loop: runs until board is correct
    add_board = draw_board(board_lib, board_idx);
    board_lib{1}=add_board;
end

function new_board = user_input(board,org)
    %Takes a users mouse and number input
    % Returns all added user values
    
    [x,y] = ginput(1);
    pos_x = ceil(x);
    pos_y = ceil(y);
    new_row = board{10-pos_y};
    org_row = org{10-pos_y};
    if org_row(pos_x) == '0'
        % creates highlight square around cell
        sq_x = [pos_x-1 pos_x-1 pos_x pos_x pos_x-1];
        sq_y = [pos_y-1 pos_y pos_y pos_y-1 pos_y-1]; 
        highlight = plot(sq_x,sq_y,'b', 'LineWidth',3);
        
        x = input('Input: ');
        set(highlight,'Visible','off')
        new_row(pos_x) = int2str(x);
        board(10-pos_y) = {new_row};
    end
    new_board = board;

    
end
 

function fill_board(board,n)
    %Add values to board
    for y = [1:9]
        row = board{y};
        for x = [1:9]
            if row(x) ~= '0'
                if n == 0
                    text(x-.6,9.5-y,row(x),'FontSize',22)
                else
                    text(x-.6,9.5-y,row(x),'Color','blue','FontSize',22)
                end
            end
        end
    end
end 

function new_board = draw_board(lib,idx)
    %draws board using original board and user inputs
    
    add_board = cellstr(reshape(lib{1},9,[])');
    org_board = cellstr(reshape(lib{idx},9,[])');
    clf
    figure('Name','Suduko');
    plot(-1. -1)
    hold on
    axis([0 9 0 9])
    set(gca,'xTick',0:9)
    set(gca,'yTick',0:9)
    set(gca,'xTickLabel','')
    set(gca,'yTickLabel','')
    xlabel('Player: X')
    grid on
    for i = 1:2
        plot([3*i 3*i],[0 9],'k', 'LineWidth',3)
        plot([0 9],[3*i 3*i],'k', 'LineWidth',3)
    end
    fill_board(org_board,0);
    fill_board(add_board,1);
    add_board = user_input(add_board,org_board);
    new_board = strjoin(add_board,'');

end


function win = check_correct(org,lib,ans,idx)
% Checks to see if board is correct
% Returns bool val
    add_board = lib{idx};
    ans_board = ans{idx};
    for i = 1:length(org)
        if org(i) == '0'
            org(i) = add_board(i);
        end
    end
    org
    ans_board
    if isequal(org,ans_board)
        text(2,4,'WINNER!!','FontSize',50,'Color','red')
        win = 1;
    end 
    win = 0;
end
