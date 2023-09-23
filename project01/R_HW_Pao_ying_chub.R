## HW02_Pao_ying_chub

m_game <- function(){
  print("Instruction: This is a game pao ying chub")
  print("Choices: We have 3 choices are rock, scissor, paper")
  print("Rules : rock win scissor 1 point
                 scissor win paper 1 point
                 paper win rock 1 point
                 and choose same 0 point")
  print("If you want to end this game please type 'exit' for stop")

  options <- c("rock", "scissor", "paper")
  round <- 0
  win <- 0
  lose <- 0
  tie <- 0

  while (TRUE){
    cat("choose one option: ")
    user_select <- readLines("stdin", 1)
    computer_select <- sample (options, 1)
    if(user_select == "exit"){
      print("Thank you for play this game")
      print(paste("You play" , round, "rounds."))
      print(paste("You win", win, "games."))
      print(paste("You lose", lose,"games."))
      print(paste("You tie", tie, "games."))
      break
    } else if (user_select == "rock" & computer_select == "scissor"){
      print("You win")
      round <- round + 1
      win <- win + 1
    } else if (user_select == "scissor" & computer_select == "paper"){
      print("You win")
      round <- round + 1
      win <- win + 1
    } else if (user_select == "paper" & computer_select == "rock"){
      print("You win")
      round <- round + 1
      win <- win + 1
    } else if (user_select == "scissor" & computer_select == "rock"){
      print("You lose")
      round <- round + 1
      lose <- lose + 1
    } else if (user_select == "paper" & computer_select == "scissor"){
      print("You lose")
      round <- round + 1
      lose <- lose + 1
    } else if (user_select == "rock" & computer_select == "paper"){
      print("You lose")
      round <- round + 1
      lose <- lose + 1
    } else if (user_select == computer_select){
      print("tie")
      round <- round + 1
      tie <- tie + 1
    } else {
      print("Your choices not correct.")
    }
  }
}

m_game()
