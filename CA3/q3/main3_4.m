dia1 = trainedModel.predictFcn(diabetesvalidation) ;
dia2 = table2array(diabetesvalidation) ;
dia2 = dia2(:,7) ;
s = dia1==dia2 ;
similarity = (sum(s)/numel(s))*100
