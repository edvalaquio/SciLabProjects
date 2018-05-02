Names = ["Outlook" "Temperature" "Humidity" "Windy" "Play"]
// dataset = [
//     "sunny" "hot" "high" "false" "no"
//     "sunny" "hot" "high" "true" "no"
//     "overcast" "hot" "high" "false" "yes"
//     "rainy" "mild" "high" "false" "yes"
//     "rainy" "cool" "normal" "false" "yes"
//     "rainy" "cool" "normal" "true" "no"
//     "overcast" "cool" "normal" "true" "yes"
//     "sunny" "mild" "high" "false" "no"
//     "sunny" "cool" "normal" "false" "yes"
//     "rainy" "mild" "normal" "false" "yes"
//     "sunny" "mild" "normal" "true" "yes"
//     "overcast" "mild" "high" "true" "yes"
//     "overcast" "hot" "normal" "false" "yes"
//     "sunny" "mild" "high" "true" "no"
// ]
dataset = [
    "sunny" "hot" "high" "false" "no"
    "sunny" "hot" "high" "true" "no"
    "overcast" "hot" "high" "false" "yes"
    "rainy" "mild" "high" "false" "yes"
    "rainy" "cool" "normal" "false" "yes"
    "rainy" "cool" "normal" "true" "no"
    "overcast" "cool" "normal" "true" "yes"
    "sunny" "mild" "high" "false" "no"
    "sunny" "cool" "normal" "false" "yes"
    "rainy" "mild" "normal" "false" "yes"
    "sunny" "mild" "normal" "true" "yes"
    "overcast" "mild" "high" "true" "yes"
    "overcast" "hot" "normal" "false" "yes"
    "sunny" "mild" "high" "true" "no"
]
//Data coming from 'dataset' variable is counted.
numPlay = [
    size(dataset(dataset(:,5)=="yes",5),1) size(dataset(dataset(:,5)=="no",5),1)
]
 printf("Num of playing")
 disp(numPlay)

numOut = [
    size(dataset(dataset(:,1)=="sunny" & dataset(:,5)=="yes",5),1) size(dataset(dataset(:,1)=="sunny" & dataset(:,5)=="no",5),1)
    size(dataset(dataset(:,1)=="overcast" & dataset(:,5)=="yes",5),1) size(dataset(dataset(:,1)=="overcast" & dataset(:,5)=="no",5),1)
    size(dataset(dataset(:,1)=="rainy" & dataset(:,5)=="yes",5),1) size(dataset(dataset(:,1)=="rainy" & dataset(:,5)=="no",5),1)
]
 printf("Num of outlook")
 disp(numOut)

numTemp = [
    size(dataset(dataset(:, 2) == "hot" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 2) == "hot" & dataset(:, 5) == "no", 5), 1) 
    size(dataset(dataset(:, 2) == "mild" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 2) == "mild" & dataset(:, 5) == "no", 5), 1) 
    size(dataset(dataset(:, 2) == "cool" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 2) == "cool" & dataset(:, 5) == "no", 5), 1) 
]
 printf("Num of temp")
 disp(numTemp)

numHum = [
    size(dataset(dataset(:, 3) == "high" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 3) == "high" & dataset(:, 5) == "no", 5), 1) 
    size(dataset(dataset(:, 3) == "normal" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 3) == "normal" & dataset(:, 5) == "no", 5), 1) 
]
 printf("Num of humidity")
 disp(numHum)

numWin = [
    size(dataset(dataset(:, 4) == "false" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 4) == "false" & dataset(:, 5) == "no", 5), 1) 
    size(dataset(dataset(:, 4) == "true" & dataset(:, 5) == "yes", 5), 1) size(dataset(dataset(:, 4) == "true" & dataset(:, 5) == "no", 5), 1) 
]
 printf("Num of windy")
 disp(numWin)

//Iterate through the given data column by column. 
//If there exists a column that has a 0 value, perform lambda smoothing over the whole column.
//If otherwise, we obtain the probability  by dividing the actual number of (event) to the actual number of plays.
for i = 1:1:2
    
    lambda = 0.5
    if(isempty(find(numOut(:, i) == 0))) then
        numOut(:, i) = numOut(:, i) / numPlay(i)
    else
        numOut(:, i) = (numOut(:, i) + lambda) / (numPlay(i) + (size(numOut, 1) * lambda))
    end
    
    if(isempty(find(numTemp(:, i) == 0))) then
        numTemp(:, i) = numTemp(:, i) / numPlay(i)
    else
        numTemp(:, i) = (numTemp(:, i) + lambda) / (numPlay(i) + (size(numTemp, 1) * lambda))
    end

    if(isempty(find(numHum(:, i) == 0))) then
        numHum(:, i) = numHum(:, i) / numPlay(i)
    else
        numHum(:, i) = (numHum(:, i) + lambda) / (numPlay(i) + (size(numHum, 1) * lambda))
    end

    if(isempty(find(numWin(:, i) == 0))) then
        numWin(:, i) = numWin(:, i) / numPlay(i)
    else
        numWin(:, i) = (numWin(:, i) + lambda) / (numPlay(i) + (size(numWin, 1) * lambda))
    end

end

//Divide the number of yes plays and no plays by the actual number of plays
temp = numPlay
for i = 1:1:2
    numPlay(i) = numPlay(i)/(temp(1) + temp(2))    
end
disp(numPlay)

printf("Enter outlook:\n")
printf("1: sunny\n")
printf("2: overcast\n")
printf("3: rainy\n")
ansOut = scanf("%d")

printf("\nEnter temperature:\n")
printf("1: hot\n")
printf("2: mild\n")
printf("3: cool\n")
ansTemp = scanf("%d")

printf("\nEnter humidity:\n")
printf("1: high\n")
printf("2: normal\n")
ansHum = scanf("%d")

printf("\nEnter windy:\n")
printf("1: false\n")
printf("2: true\n")
ansWin = scanf("%d")

printf("\nEnter play:\n")
printf("1: yes\n")
printf("2: no\n")
ansPlay = scanf("%d")

numerator = numOut(ansOut, ansPlay) * numTemp(ansTemp, ansPlay) * numHum(ansHum, ansPlay) * numWin(ansWin, ansPlay) * numPlay(ansPlay)
//if (ansPlay == 1) then
//    temp = 2
//elseif (ansPlay == 2) then 
//    temp = 1
//end
inverse = 3-ansPlay

denominator = numerator + numOut(ansOut, inverse) * numTemp(ansTemp, inverse) * numHum(ansHum, inverse) * numWin(ansWin, inverse) * numPlay(inverse)

answer = numerator/denominator

disp(numOut);
disp(numTemp);
disp(numHum);
disp(numWin);
disp(numPlay);

disp(answer);