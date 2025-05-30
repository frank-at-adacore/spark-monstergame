with Ada.Tags;

with Pieces;
with Location;

-- Ada 2005
private with Ada.Containers.Doubly_Linked_Lists;

package Game_Board_Cell with
  SPARK_Mode
is

   type Cell_Class is tagged private;

   type Cell_Class_Ptr is access all Cell_Class'Class;

   procedure Add_Piece
     (Object : in out Cell_Class;
      Piece  :        Pieces.Piece_Class_Ptr);

   -- Attempt to get a player piece from the cell.
   --
   -- Status indicates whether piece was found and returned
   procedure Get_Piece
     (Object    : in out Cell_Class;
      Piece_Tag :        Ada.Tags.Tag;
      Remove    :        Boolean := False;
      Piece     :    out Pieces.Piece_Class_Ptr;
      Status    :    out Boolean);

   -- Number of Pieces in the cell.
   function Piece_Count
     (Object : in Cell_Class)
      return Natural;

   -- Draws all pieces, next to each other on same line.
   procedure Draw
     (-- Instance
      Object : in Cell_Class);

   -- Is there another piece on this cell that precludes another piece from being placed here?
   -- E.g. an obstacle.
   function Piece_Can_Be_Added
     (Object : in Cell_Class)
      return Boolean;

   function Make
     (-- Where the cell is on the board
       Its_Location : Location.Location_Class;
      -- Height of the Cell
      Height        : Natural;

      -- Width of Cell
      Width : Natural)
      return Cell_Class_Ptr;

   function Board_Location
     (Object : Cell_Class)
      return Location.Location_Class;
private

   use Ada.Containers;
   -- Need to make the pointer operators visible to instantiate list.
   use type Pieces.Piece_Class_Ptr;

   package Pieces_List_Pkg is new Doubly_Linked_Lists
     (Element_Type => Pieces.Piece_Class_Ptr);

   type Cell_Class is tagged record

      -- Container for all the pieces that can exist in this cell.
      Piece_List : Pieces_List_Pkg.List;

      -- A cell has a location.
      My_Location : Location.Location_Class;

      -- Cell dimensions
      Height : Natural;
      Width  : Natural;
   end record;

end Game_Board_Cell;
