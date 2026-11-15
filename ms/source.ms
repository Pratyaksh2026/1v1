init = function()

player1_x = -40
player2_x = 40

player1_y = -20
player2_y = -20

player1_jump_speed = 0
player2_jump_speed = 0

player1_health = 100
player2_health = 100

player1_score = 0
player2_score = 0

player1_shoot = false
player2_shoot = false

player1_jump = false
player2_jump = false

player1_block = false
player2_block = false

player1_apple_active = false
player2_apple_active = false

player1_apple_x = 0
player2_apple_x = 0

player1_apple_y = 15
player2_apple_y = 15

apple_speed = 5

round_over = false
match_over = false

winner_text = ""


end

update = function()

if match_over then return end

if round_over then

    if keyboard.SPACE then

        if player1_score >= 5 or player2_score >= 5 then

            match_over = true

        else

            player1_x = -40
            player2_x = 40

            player1_y = -20
            player2_y = -20

            player1_jump_speed = 0
            player2_jump_speed = 0

            player1_health = 100
            player2_health = 100

            player1_apple_active = false
            player2_apple_active = false

            player1_shoot = false
            player2_shoot = false

            player1_jump = false
            player2_jump = false

            player1_block = false
            player2_block = false

            round_over = false

        end

    end

    return

end


// PLAYER 1 MOVEMENT - W AND S ONLY

player1_move = 0

if keyboard.W then
    player1_move = -2
end

if keyboard.S then
    player1_move = 2
end

player1_x += player1_move


// PLAYER 2 MOVEMENT - ARROW KEYS ONLY

player2_move = 0

if keyboard.LEFT then
    player2_move = -2
end

if keyboard.RIGHT then
    player2_move = 2
end

player2_x += player2_move


// PLAYER 1 JUMP - Z

if keyboard.Z and player1_jump == false then

    player1_jump = true
    player1_jump_speed = 7

end


// PLAYER 2 JUMP - M

if keyboard.M and player2_jump == false then

    player2_jump = true
    player2_jump_speed = 7

end


// PLAYER 1 GRAVITY

if player1_jump then

    player1_y += player1_jump_speed
    player1_jump_speed -= 0.35

    if player1_y <= -20 then

        player1_y = -20
        player1_jump = false
        player1_jump_speed = 0

    end

end


// PLAYER 2 GRAVITY

if player2_jump then

    player2_y += player2_jump_speed
    player2_jump_speed -= 0.35

    if player2_y <= -20 then

        player2_y = -20
        player2_jump = false
        player2_jump_speed = 0

    end

end


// PLAYER 1 BLOCK - F

player1_block = keyboard.F


// PLAYER 2 BLOCK - J

player2_block = keyboard.J


// PLAYER 1 SHOOTS - Q

if keyboard.Q and player1_shoot == false then

    player1_shoot = true

    if player1_apple_active == false then

        player1_apple_active = true
        player1_apple_x = player1_x + 10
        player1_apple_y = player1_y + 15

    end

end

if not keyboard.Q then
    player1_shoot = false
end


// PLAYER 2 SHOOTS - P

if keyboard.P and player2_shoot == false then

    player2_shoot = true

    if player2_apple_active == false then

        player2_apple_active = true
        player2_apple_x = player2_x - 10
        player2_apple_y = player2_y + 15

    end

end

if not keyboard.P then
    player2_shoot = false
end


// PLAYER 1 APPLE

if player1_apple_active then

    player1_apple_x += apple_speed

    if abs(player1_apple_x - player2_x) < 10 then

        if abs(player1_apple_y - (player2_y + 15)) < 15 then

            if player2_block then

                player1_apple_active = false

            else

                player2_health -= 10
                player1_apple_active = false

            end

        end

    end

    if player1_apple_x > 110 then
        player1_apple_active = false
    end

end


// PLAYER 2 APPLE

if player2_apple_active then

    player2_apple_x -= apple_speed

    if abs(player2_apple_x - player1_x) < 10 then

        if abs(player2_apple_y - (player1_y + 15)) < 15 then

            if player1_block then

                player2_apple_active = false

            else

                player1_health -= 10
                player2_apple_active = false

            end

        end

    end

    if player2_apple_x < -110 then
        player2_apple_active = false
    end

end


// PLAYER BOUNDARIES

player1_x = max(-90, min(90, player1_x))
player2_x = max(-90, min(90, player2_x))


// HEALTH LIMITS

player1_health = max(0, player1_health)
player2_health = max(0, player2_health)


// ROUND WINNER

if player2_health <= 0 then

    player1_score += 1
    winner_text = "PLAYER 1 WINS THE ROUND!"
    round_over = true

elsif player1_health <= 0 then

    player2_score += 1
    winner_text = "PLAYER 2 WINS THE ROUND!"
    round_over = true

end


// MATCH WINNER

if player1_score >= 5 then

    match_over = true
    winner_text = "PLAYER 1 WINS THE MATCH!"

end

if player2_score >= 5 then

    match_over = true
    winner_text = "PLAYER 2 WINS THE MATCH!"

end


end

draw = function()

screen.clear()


// BACKGROUND

screen.drawSprite("background", 0, 0, 200, 150)


// PLAYER 1

if player1_health > 0 then

    screen.drawSprite("player", player1_x, player1_y, 12, 25)

end


// PLAYER 2

if player2_health > 0 then

    screen.drawSprite("john", player2_x, player2_y, 12, 25)

end


// PLAYER 1 APPLE

if player1_apple_active then

    screen.drawSprite("apple", player1_apple_x, player1_apple_y, 12, 12)

end


// PLAYER 2 APPLE

if player2_apple_active then

    screen.drawSprite("apple", player2_apple_x, player2_apple_y, 12, 12)

end


// BLOCKING INDICATORS

if player1_block then

    screen.drawText("BLOCK!", player1_x, player1_y + 22, 9, "cyan")

end

if player2_block then

    screen.drawText("BLOCK!", player2_x, player2_y + 22, 9, "cyan")

end


// HEALTH

screen.drawText("PLAYER 1 HP: " + player1_health, -65, 80, 12, "white")

screen.drawText("PLAYER 2 HP: " + player2_health, 65, 80, 12, "white")


// SCOREBOARD

screen.drawText("PLAYER 1: " + player1_score, -55, 60, 14, "yellow")

screen.drawText("PLAYER 2: " + player2_score, 55, 60, 14, "yellow")


// ROUND OVER

if round_over and match_over == false then

    screen.drawText(winner_text, 0, 25, 15, "yellow")

    screen.drawText("PRESS SPACE FOR NEXT ROUND", 0, -15, 10, "white")

end


// MATCH OVER

if match_over then

    screen.drawText("MATCH FINISHED!", 0, 35, 20, "yellow")

    screen.drawText(winner_text, 0, 5, 15, "white")

    screen.drawText("FINAL SCORE", 0, -20, 12, "white")

    screen.drawText(player1_score + " - " + player2_score, 0, -40, 20, "yellow")

end


// CONTROLS

if not round_over and not match_over then

    screen.drawText("P1: W/S + Z + Q + F", -45, -75, 9, "white")

    screen.drawText("P2: ARROWS + M + P + J", 45, -85, 9, "white")

end


end
