function codedpic = coding(message, initialpic, mapset)
    
    % checking size of the message
    if length(message)*5 < (size(initialpic, 1)-rem(size(initialpic, 1), 5))*(size(initialpic, 2)-rem(size(initialpic, 2), 5))
        % Turning message into binary
        message_len = length(message);
        binarymessage = ''; % Initialize binary message string
        for i = 1:message_len
            ch = message(i);
            found = false;
            for j = 1:32
                if ch == mapset{1, j}
                    binarymessage = [binarymessage, mapset{2, j}]; % Append binary representation of character to binary message
                    found = true;
                    break;
                end
            end
            if ~found
                fprintf('Character "%c" not found in mapset. Skipping...\n', ch);
            end
        end
        binarymessage_len = length(binarymessage);
    
        % Finding blocks with most contrast values
        blocks = {};
        contrasts = [];
        indices = [];
        for i = 1:5:size(initialpic, 1)-rem(size(initialpic, 1), 5)
            for j = 1:5:size(initialpic, 2)-rem(size(initialpic, 2), 5)
                block = initialpic(i:i+4, j:j+4);
                blockWithoutLSB = bitand(block, 254); % Clear LSB
                contrast = max(blockWithoutLSB(:)) - min(blockWithoutLSB(:));
                blocks{end+1} = block;
                contrasts(end+1) = contrast;
                indices(end+1, :) = [i, j];
            end
        end
        [sortedContrasts, sortIdx] = sort(contrasts, 'descend');
        sortedBlocks = blocks(sortIdx);
        sortedIndices = indices(sortIdx, :);
    
        % Writing message in the blocks
        i = 1;
        for l = 1:length(sortedBlocks)
            block_to_change = sortedBlocks{l};
            i_start = sortedIndices(l, 1);
            j_start = sortedIndices(l, 2);
            for m = 1:size(block_to_change, 1)
                for n = 1:size(block_to_change, 2)
                    val = block_to_change(m, n);
                    if i <= binarymessage_len
                        val_bin = dec2bin(val, 8);
                        val_bin(end) = binarymessage(i);
                        block_to_change(m, n) = bin2dec(val_bin); % Convert back to decimal and store in the block
                        i = i + 1;
                    else
                        break;
                    end
                end
                if i > binarymessage_len
                    break;
                end
            end
            initialpic(i_start:i_start+4, j_start:j_start+4) = block_to_change;
        end
        codedpic = initialpic;
    else
        disp('message is too large!') ;
        codedpic = 1 ;
    end
end

