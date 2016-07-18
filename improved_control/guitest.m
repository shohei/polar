function guitest


figure(1);

subplot(121);
xlim([-15,15]);
ylim([-15,15]);
text(0.5,0.5,'text1 in center');


subplot(122)
text(0.5,0.5,'text2 in center');


% FigH = figure;
% AxesH = axes('Parent', FigH, ...
%   'Units', 'normalized', ...
%   'Position', [0, 0, 1, 1], ...
%   'Visible', 'off', ...
%   'XLim', [0, 1], ...
%   'YLim', [0, 1], ...
%   'NextPlot', 'add');
% TextH = text(0.5,0.5, 'Top left', ...
%   'HorizontalAlignment', 'left', ...
%   'VerticalAlignment', 'top');






end