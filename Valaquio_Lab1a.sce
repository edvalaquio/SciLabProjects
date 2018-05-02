pA = [0.2 0.8]
pL = [0.8 0.1 0.2 0.9]
pQ = [0.85 0.05 0.15 0.95]
pE = [0.9 0.55 0.4 0.05 0.1 0.45 0.6 0.95]

while %T
    
    printf("Enter whether A is pass (1) or fail (0): ")
    probA = scanf("%d")
    printf("Enter whether L is pass (1) or fail (0): ")
    probL = scanf("%d")
    printf("Enter whether Q is pass (1) or fail (0): ")
    probQ = scanf("%d")
    printf("Enter whether E is pass (1) or fail (0): ")
    probE = scanf("%d")
    
    if (probA <> 0 & probA <> 1) then
        probA = [0 1]
    else
        probA = [probA]
    end
    if (probL <> 0 & probL <> 1) then
        probL = [0 1]
    else
        probL = [probL]
    end
    if (probQ <> 0 & probQ <> 1) then
        probQ = [0 1]
    else
        probQ = [probQ]
    end
    if (probE <> 0 & probE <> 1) then
        probE = [0 1]
    else
        probE = [probE]
    end
    
    probability = 0
    for i = 1:1:2
        numA = (probA(i) * 2^0) + 1
        for j = 1:1:2
            numL = (probL(j) * 2^1) + (probA(i) * 2^0) + 1
            for k = 1:1:2
                numQ = (probL(k) * 2^1) + (probA(i) * 2^0) + 1
                for l = 1:1:2
                    numE = (probE(l) * 2^2) + (probL(j) * 2^1) + (probQ(k) * 2^0) + 1

                    probability = probability + pA(numA)*pL(numL)*pQ(numQ)*pE(numE)

                    if (size(probE) == 1) then
                        break
                    end
                end
                if (size(probQ) == 1) then
                    break
                end
            end
            if (size(probL) == 1) then
                break
            end
        end
        if (size(probA) == 1) then
            break
        end
    end
        
//    probability = 0
//    for i = 1:1:2
//        numA = (probA(i) * 2^0) + 1
//        numL = (probL * 2^1) + (probA(i) * 2^0) + 1
//        numQ = (probL * 2^1) + (probA(i) * 2^0) + 1
//        numE = (probE * 2^2) + (probL * 2^1) + (probQ * 2^0) + 1
//        probability = probability + pA(numA)*pL(numL)*pQ(numQ)*pE(numE)
//    end
    
    printf("The probability is\n")
    disp(probability)
    printf("Do you want to continue?")
    ans = scanf("%d")
    if(ans == 0)
        break
    end
    
end
