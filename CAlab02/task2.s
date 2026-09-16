    li x22, 12    
    li x23, 4          
    li x20, 2          
    
    li x5, 1           
    beq x20, x5, case1  

    li x5, 2           
    beq x20, x5, case2

    li x5, 3            
    beq x20, x5, case3   

    li x5, 4            
    beq x20, x5, case4  

    j default      

case1:          
    add x21, x22, x23
    j end_switch

case2:           
    sub x21, x22, x23
    j end_switch

case3:                
    slli x21, x22, 1    
    j end_switch

case4:          
    srai x21, x22, 1    
    j end_switch

default:           
    add x21, x0, x0

end_switch:
end:
    j end