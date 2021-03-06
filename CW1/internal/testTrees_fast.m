function label = testTrees_fast(data,tree,weakLearner)
% Faster version - pass all data at same time
for T = 1:length(tree)
    idx{1} = 1:size(data,1);
    for n = 1:length(tree(T).node)
        if ~tree(T).node(n).dim
            leaf_idx = tree(T).node(n).leaf_idx;
            if ~isempty(tree(T).leaf(leaf_idx))
                label(idx{n}',T) = tree(T).leaf(leaf_idx).label;
            end
            continue;
        end
        switch weakLearner
            case 'axisAligned'
                idx_left = data(idx{n},tree(T).node(n).dim) -...
                    tree(T).node(n).t < 0;
            case 'twoPixelTest'
                idx_left = (data(idx{n},tree(T).node(n).dim(2)) -...
                    data(idx{n},tree(T).node(n).dim(1))) -...
                    tree(T).node(n).t < 0;
            case 'linear'
                idx_left = (data(idx{n},tree(T).node(n).dim(2)) -...
                    tree(T).node(n).t(2)*data(idx{n},tree(T).node(n).dim(1))) -...
                    tree(T).node(n).t(1) < 0;
            case 'nonLinear'
                idx_left = data(idx{n},tree(T).node(n).dim(2)) -...
                    tree(T).node(n).t(3)*((data(idx{n},tree(T).node(n).dim(1))).^2) -...
                    tree(T).node(n).t(2)*data(idx{n},tree(T).node(n).dim(1)) -...
                    tree(T).node(n).t(1)< 0;
        end        
        idx{n*2} = idx{n}(idx_left');
        idx{n*2+1} = idx{n}(~idx_left');
    end
end

end

