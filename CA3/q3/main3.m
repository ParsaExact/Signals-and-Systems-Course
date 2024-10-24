dia1 = trainedModel.predictFcn(diabetestraining) ;
dia2 = table2array(diabetestraining) ;
dia2 = dia2(:,7) ;
s = dia1==dia2 ;
similarity = (sum(s)/numel(s))*100
