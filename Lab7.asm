# Full Name + Student Id:(لجين الصديقي 446001578)(نوران الانصاري 446000744)(لجين التركستاني446002072)(راما الثبيتي 446012670)
# Labx7+8: The program calculates the user’s vitamin deficiency and determines the number of days needed to reach the normal level based on the amount of food entered.

.data 
#                 [ iron section ]
iron_current: .word 0   #user input: current Iron level
iron_meal:    .word 0   #amount of food eaten(grams)
iron_missing: .word 0   #calculated Iron deficiency
iron_days:    .word 0   #days needed to reach normal level
iron_normal:  .word 18  #normal Iron level
iron_food:    .word 3   #Iron amount in 100g lentils 

#                    [ Vitamin D section ]
vitD_current: .word 0   #user input: current Vitamin D level
vitD_meal:    .word 0   #amount of food eaten(grams)
vitD_missing: .word 0   #calculated Vitamin D deficiency
vitD_days:    .word 0   #days needed to reach normal level
vitD_normal:  .word 30  #normal Vitamin D level
vitD_food:    .word 10  #Vitamin D amount in 100g salmon
newline:        .asciiz "\n"
#                    [ Messages ]
msgIronInput:      .asciiz "Enter your current Iron level: "
msgIronDef:        .asciiz "Iron deficiency: "
msgIronFood:       .asciiz "Enter the amount of Iron-rich food (grams): "
msgIronDays:       .asciiz "Days needed to reach normal Iron level: "
msgIronIntake:     .asciiz "iron intake from food today:"

msgVitDInput:      .asciiz "Enter your current Vitamin D level: "
msgVitDDef: .asciiz "Vitamin D deficiency: "
msgVitDFood:       .asciiz "Enter the amount of Vitamin D-rich food (grams): "
msgVitDDays:       .asciiz "Days needed to reach normal Vitamin D level: "
msgVitDIntake: .asciiz "Vitamin D intake from food today: "

.text 
main:

#                      [ iron ]

# Print: Enter Iron level
li $v0, 4
la $a0, msgIronInput
syscall

# Input Iron level
li $v0, 5     
syscall 
move $t1, $v0   

# exit if negative iron level 
bltz $t1, exitNegative

# Calculate deficiency
lw $t0, iron_normal      
sub $t3, $t0, $t1        

# Print: Iron deficiency
li $v0, 4
la $a0, msgIronDef
syscall

li $v0, 1
move $a0, $t3
syscall

# Newline
li $v0,4
la $a0,newline
syscall 

sw $t3, iron_missing     

# Print: Enter iron food amount
li $v0, 4
la $a0, msgIronFood
syscall

# Input food grams
li $v0, 5    
syscall
move $t4, $v0  

lw $t7, iron_food

#------------------------------------------------------------------
# mul: iron_intake = grams * 3 / 100
mul $t6, $t4, $t7    
li $t8, 100 #خزنا في $t8 القيمه 100
div $t6, $t8
mflo $t6#يخزن العدد الصحيح 


# Print iron intake
li $v0, 4
la $a0, msgIronIntake
syscall

li $v0, 1
move $a0, $t6
syscall

# Newline
li $v0, 4
la $a0, newline
syscall
#------------------------------------------------------------------
# Days = deficiency / iron_intake
div $t3, $t6  # t3 هوا كميه الحديد الي ناقص عنده و t6هوا كميه الحديد الي اخذها اليوم
mflo $t5   #يعكيني عدد صحيح للايام الي يحتاجها عشان يكتمل الحديد     
sw $t4, iron_meal   #يخزن كميه الاكل الي ادخلها المستخدم في متغير iron_mealفي الذاكره

# Print: days needed
li $v0, 4
la $a0, msgIronDays
syscall

li $v0, 1    
move $a0, $t5
syscall

# Newline
li $v0,4    
la $a0,newline
syscall 


#                      [ Vitamin D ]

# Print: Enter Vitamin D level
li $v0, 4
la $a0, msgVitDInput
syscall

# Input Vitamin D
li $v0,5   
syscall 
move $t1,$v0 

# exit if negative Vit D level 
bltz $t1, exitNegative

lw $t0, vitD_normal 
sub $t3, $t0, $t1  

# Print: deficiency
li $v0, 4
la $a0, msgVitDDef
syscall

li $v0, 1   
move $a0, $t3
syscall

li $v0,4   
la $a0,newline
syscall 

sw $t3, vitD_missing    

# Print: enter food grams
li $v0, 4
la $a0, msgVitDFood
syscall

# Input food grams
li $v0,5    
syscall 
move $t4,$v0
sw $t4, vitD_meal

lw $t7, vitD_food       

# mul for Vitamin D intake: vitD_intake = grams * 10 / 100 
mul $t6, $t4, $t7        # t6 = grams * vitD_food
li  $t8, 100
div $t6, $t8
mflo $t6                 # t6 = vitD intake from food (NOT used later

li $v0, 4
la $a0, msgVitDIntake
syscall

li $v0, 1
move $a0, $t6
syscall

li $v0, 4
la $a0, newline
syscall

#days calculation 
div $t3,$t7   
mflo $t5
sw $t5, vitD_days

# Print: days needed
li $v0, 4
la $a0, msgVitDDays
syscall

li $v0, 1   
move $a0, $t5
syscall

# exit program
exitNegative:
li $v0, 10  
syscall
