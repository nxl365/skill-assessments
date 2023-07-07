### my answer of the Python programming assessment

import random,time

def print_board(board):
    print('\n~~~~~~~~~~~~~')
    print('  0 1 2')  # print column indexes
    for i, row in enumerate(board):  
        print(i, ' '.join(row))  # print row index followed by the row
    print('~~~~~~~~~~~~~')



def check_win(board):
    # check horizontal, vertical and diagonal lines
    lines = [
        [board[i][0] for i in range(3)],  # vertical 1
        [board[i][1] for i in range(3)],  # vertical 2
        [board[i][2] for i in range(3)],  # vertical 3
        board[0],  # horizontal 1
        board[1],  # horizontal 2
        board[2],  # horizontal 3
        [board[i][i] for i in range(3)],  # diagonal 1
        [board[i][2 - i] for i in range(3)]  # diagonal 2
    ]
    if ['X'] * 3 in lines:
        return 'X'
    if ['O'] * 3 in lines:
        return 'O'
    return None



def get_valid_moves(board):
    return [(i, j) for i in range(3) for j in range(3) if board[i][j] == '.']   # only give empty spots



def player_turn(player,board):
    while True:
        try:
            row = int(input(f'Player \'{player}\' turn: \nWhich row? '))
            col = int(input('Which column? '))
        except ValueError:
            print("Invalid input. Please enter a number.")
            continue
        
        if (row, col) not in get_valid_moves(board):
            print("Invalid move. Please try again.")
            continue


        confirmation = input(f'Place \'{player}\' at row {row}, column {col}? [y/n] ').lower()
        if confirmation == 'n':
            continue
        elif confirmation == 'y':
            board[row][col] = player
            print('Move placed!')
            break
        else:
            print("Please only input 'y' or 'n'.")
            continue
    
    print('Current board:')
    print_board(board)



def pc_turn(computer, board):
    print(f'Computer \'{computer}\' turn: computer move registered.')
    row, col = random.choice(get_valid_moves(board))
    board[row][col] = computer

    print('Current board:')
    print_board(board)



def check_game_status(board,role):
    outcome = check_win(board)
    if outcome == role:
        print(f'\'{outcome}\' wins!')
        return True

    if len(get_valid_moves(board)) == 0:
        print('The game ended in a stalemate.')
        return True

    return False



def tic_tac_toe():
    board = [['.', '.', '.'] for _ in range(3)]

    # the player chooses a role
    player = input("Choose a role 'X' or 'O': ").upper()
    while player not in ['X', 'O']:
        print("Please only input 'X' or 'O'.")
        player = input("Choose a role 'X' or 'O': ").upper()

    computer = 'O' if player == 'X' else 'X'

    # start round
    round_counter = 1
    while True:
        print('\n################')
        print(f'### Round #{round_counter} ###')
        print('################')
        print('\nCurrent board:')
        print_board(board)

        if player == 'X':
            # player's move
            player_turn(player,board)           
            if check_game_status(board, player):
                break

            # Computer's move: just randomly move
            time.sleep(2)
            pc_turn(computer, board)
            if check_game_status(board, computer):
                break


        elif player == 'O':

            # Computer's move: just randomly move
            time.sleep(2)
            pc_turn(computer, board)
            if check_game_status(board, computer):
                break

            # player's move
            player_turn(player,board)           
            if check_game_status(board, player):
                break


        round_counter += 1
        time.sleep(2)


tic_tac_toe()
