function result = dilation(sourceimg, selement)
% This function dilates the given source image according to a structuring element
% selement. It simply pads the sourceimg matrix with the extra dimensions
% that structuring element has according to the corner values with 0 and
% traverse the whole matrix to check for overlapping 1's.
% The definition of dilation is used from Auckland University's handouts:
% https://www.cs.auckland.ac.nz/courses/compsci773s1c/lectures/ImageProcessing-html/topic4.htm
% Author: Arda Kıray (21302072)

% row and column number of the structuring element
srow = size(selement, 1);
scol = size(selement, 2);

error = "Structuring element dimensions must be even numbers";

% Below conditionals checks the element dimensions and catch an error
if mod(srow,2) == 0
    disp(error);
    return
end
if mod(scol,2) == 0
    disp(error);
    return
end

center = [ceil(srow/2), ceil(scol/2)]; % center of the dilation

% row and column number of the source image
imgrow = size(sourceimg, 1);
imgcol = size(sourceimg, 2);

% padarray function adds (center(1)-1) rows and columns with 0's to the
% four sides of the source image
padMatrix = padarray(sourceimg,[center(1)-1, center(2)-1], 0);

result = zeros(imgrow,imgcol);

% This loop traverses the each item in the padMatrix that comes from the
% source image and put the origin of the structuring element to that item
% and checks whether there are any overlapped 1's
for i = 1:imgcol 
    for j = 1:imgrow
        % test is the slice of the padMatrix with the size of selement
        test = padMatrix(j:(j+srow-1), i:(i+scol-1));
        
        found = 0; % boolean value for match
        % This loop checks the slice and selement for match
        for k = 1:(size(test,1) * size(test,2))
            if(selement(k) == 1)
                if(test(k) == 1)
                    found = 1;
                end
            end
        end
        
        % Result matrix update according to match
        if(found == 1)
            result(j,i) = 1;
        end
    end
end
end
        
        
    
    
    