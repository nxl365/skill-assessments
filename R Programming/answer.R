library(stringr)
library(utils)

print_board <- function(board) {
  cat("\n~~~~~~~~~~~~~\n")
  cat("  0 1 2\n")  # print column indexes
  for (i in 1:3){
    cat(i-1, str_c(board[i,], collapse = " "), "\n")  # print row index followed by the row
  }
  cat("~~~~~~~~~~~~~\n")
}

check_win <- function(board) {
  # check horizontal, vertical and diagonal lines
  lines <- list(board[1,],  # horizontal 1
                board[2,],  # horizontal 2
                board[3,],  # horizontal 3
                board[,1],  # vertical 1
                board[,2],  # vertical 2
                board[,3],  # vertical 3
                c(board[1,1], board[2,2], board[3,3]),  # diagonal 1
                c(board[1,3], board[2,2], board[3,1]))  # diagonal 2
  
  if ("X" %in% sapply(lines, function(x) all(x == "X"))){
    return('X')
  }
  
  if ("O" %in% sapply(lines, function(x) all(x == "O"))){
    return('O')
  }
  
  return(NULL)
}

get_valid_moves <- function(board) {
  valid_moves <- which(board == ".", arr.ind = TRUE)
  return(valid_moves)
}

tic_tac_toe <- function() {
  board <- matrix(rep(".", 9), nrow = 3, ncol = 3)
  
  # the player chooses a role
  cat("Choose a role 'X' or 'O': ")
  player <- toupper(readline(prompt=""))
  while (player %notin% c('X', 'O')) {
    cat("Please only input 'X' or 'O'.\n")
    cat("Choose a role 'X' or 'O': ")
    player <- toupper(readline(prompt=""))
  }
  
  computer <- ifelse(player == 'X', 'O', 'X')
  
  # start round
  round_counter <- 1
  while (TRUE) {
    cat('\n################\n')
    cat(sprintf('### Round #%s ###\n', round_counter))
    cat('################\n')
    cat('\nCurrent board:\n')
    print_board(board)
    
    # player's move
    while (TRUE) {
      cat(sprintf("Player '%s' turn: \nWhich row? ", player))
      row <- as.numeric(readline(prompt="")) + 1
      cat("Which column? ")
      col <- as.numeric(readline(prompt="")) + 1
      
      if (!c(row, col) %in% get_valid_moves(board)) {
        cat("Invalid move. Please try again.\n")
        next
      }
      
      cat(sprintf("Place '%s' at row %s, column %s? [y/n] ", player, row-1, col-1))
      confirmation <- tolower(readline(prompt=""))
      if (confirmation == 'n') {
        next
      } else if (confirmation == 'y') {
        board[row, col] <- player
        cat('Move placed!\n')
        break
      } else {
        cat("Please only input 'y' or 'n'.\n")
        next
      }
    }
    
    cat('Current board:\n')
    print_board(board)
    if (check_win(board) == player) {
      cat(sprintf("'%s' wins!\n", player))
      break
    }
    
    # Computer's move: just randomly move
    Sys.sleep(2)
    cat(sprintf("Computer '%s' turn: computer move registered.\n", computer))
    valid_moves <- get_valid_moves(board)
    random_move <- valid_moves[sample(nrow(valid_moves), 1),]
    board[random_move[1], random_move[2]] <- computer
    print_board(board)
    
    if (check_win(board) == computer) {
      cat(sprintf("'%s' wins!\n", computer))
      break
    }
    
    round_counter <- round_counter + 1
    
    Sys.sleep(2)
    
    if (nrow(get_valid_moves(board)) == 0) {
      cat('The game ended in a stalemate.\n')
      break
    }
  }
}

tic_tac_toe()
