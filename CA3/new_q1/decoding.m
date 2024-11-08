function DcodedMessage = decoding(codedpic, Alphabet, blocksize)

    % Finding blocks with most contrast value
    blocks = {};
    contrasts = [];
    for i = 1:blocksize:size(codedpic, 1)-rem(size(codedpic, 1), blocksize)
        for j = 1:blocksize:size(codedpic, 2)-rem(size(codedpic, 2), blocksize)
            block = codedpic(i:i+blocksize-1, j:j+blocksize-1);
            blockWithoutLSB = bitand(block, 254); % Clear LSB
            contrast = max(blockWithoutLSB(:)) - min(blockWithoutLSB(:));
            blocks{end+1} = block;
            contrasts(end+1) = contrast;
        end
    end
    [sortedContrasts, sortIdx] = sort(contrasts, 'descend');
    sortedBlocks = blocks(sortIdx);

    % Decoding the message
    DcodedMessageBin = '';
    for k = 1:length(sortedBlocks)
        block_to_look = sortedBlocks{k};
        for m = 1:size(block_to_look, 1)
            for n = 1:size(block_to_look, 2)
                val = block_to_look(m, n);
                val_bin = dec2bin(bitand(val, 1), 1); % Extract LSB
                DcodedMessageBin = [DcodedMessageBin val_bin];
                if length(DcodedMessageBin) >= 5 && strcmp(Alphabet(bin2dec(DcodedMessageBin(1:5))+1), ';')
                    break;
                end
            end
            if length(DcodedMessageBin) >= 5 && strcmp(Alphabet(bin2dec(DcodedMessageBin(1:5))+1), ';')
                break;
            end
        end
        if length(DcodedMessageBin) >= 5 && strcmp(Alphabet(bin2dec(DcodedMessageBin(1:5))+1), ';')
            break;
        end
    end
    
    % Translate binary representation to characters
    DcodedMessage = '';
    for i = 1:5:length(DcodedMessageBin)
        chunk = DcodedMessageBin(i:min(i+4, length(DcodedMessageBin))); % Ensure chunk size is at most 5 bits
        index = bin2dec(chunk) + 1;
        if index <= length(Alphabet)
            character = Alphabet(index);
            if strcmp(character, ';')
                break;
            else
                DcodedMessage = [DcodedMessage character];
            end
        end
    end
    disp(DcodedMessage) ;
end







