LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL; 

ENTITY MullCell IS
   PORT (xi, yi, pi, ci : IN std_logic; 
         po, co : OUT std_logic);
END MullCell;
ARCHITECTURE rtl OF MullCell IS
SIGNAL xy : std_logic;
BEGIN
   xy <= xi AND yi;
   co <= (pi AND xy) OR (pi AND ci) OR (xy AND ci);
   po <= pi XOR xy XOR ci;
END rtl;

