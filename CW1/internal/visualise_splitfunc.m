function visualise_splitfunc(idx_best,data,dim,t,ig_best,iter, learner) % Draw the split line
r = [-1.5 1.5]; % Data range

if iter == 0
    iter = 4;
end

subplot(4,4,4*(iter-1)+1);
if dim == 1
    plot([t t],[r(1),r(2)],'r');
else
    x = r(1):0.01:r(2);
    switch learner
        case 'axisAligned'
            y = t*ones(length(x));
        case 'twoPixelTest'
            y = x + t;
        case 'linear'
            y = t(2)*x + t(1);
        case 'nonLinear'
            y = t(3)*(x.^2) + t(2)*x + t(1);
    end                
    plot(x, y, 'r');
end
hold on;
plot(data(~idx_best,1), data(~idx_best,2), '*', 'MarkerEdgeColor', [.8 .6 .6], 'MarkerSize', 10);
hold on;
plot(data(idx_best,1), data(idx_best,2), '+', 'MarkerEdgeColor', [.6 .6 .8], 'MarkerSize', 10);

hold on;
plot(data(data(:,end)==1,1), data(data(:,end)==1,2), 'o', 'MarkerFaceColor', [.9 .3 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==2,1), data(data(:,end)==2,2), 'o', 'MarkerFaceColor', [.3 .9 .3], 'MarkerEdgeColor','k');
hold on;
plot(data(data(:,end)==3,1), data(data(:,end)==3,2), 'o', 'MarkerFaceColor', [.3 .3 .9], 'MarkerEdgeColor','k');

if ~iter
    title(sprintf('BEST Split. IG = %4.2f',ig_best));
else
    title(sprintf('Trial %i. IG = %4.2f',iter,ig_best));
end
axis([r(1) r(2) r(1) r(2)]);
hold off;

% histogram of base node
subplot(4,4,4*(iter-1)+2);
tmp = hist(data(:,end), unique(data(:,end)));
bar(tmp);
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of parent node');
subplot(4,4,4*(iter-1)+3);
bar(hist(data(idx_best,end), unique(data(:,end))));
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of left child node');
subplot(4,4,4*(iter-1)+4);
bar(hist(data(~idx_best,end), unique(data(:,end))));
axis([0.5 3.5 0 max(tmp)]);
title('Class histogram of right child node');
hold off;
end