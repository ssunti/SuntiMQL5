/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                         N e w O r d e r 1 . m q 5   |  
 / / |                                                 C o p y r i g h t   2 0 2 0 ,   M e t a Q u o t e s   S o f t w a r e   C o r p .   |  
 / / |                                                                                           h t t p s : / / w w w . m q l 5 . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " C o p y r i g h t   2 0 2 0 ,   M e t a Q u o t e s   S o f t w a r e   C o r p . "  
 # p r o p e r t y   l i n k             " h t t p s : / / w w w . m q l 5 . c o m "  
 # p r o p e r t y   v e r s i o n       " 1 . 0 0 "  
  
 # i n c l u d e   < T r a d e \ T r a d e . m q h >  
 # i n c l u d e   < T r a d e \ A c c o u n t I n f o . m q h >  
  
 # d e f i n e   N U M _ R A T E S   3  
  
 / / - - -   g l o b a l s  
 C T r a d e 	 	 	 g _ t r a d e ; 	 	 	 	 	 / /   t r a d e   o b j e c t  
 d o u b l e 	 	 	 g _ p o i n t S i z e   =   0 . ; 	 	 / /   i n i t i a l i z e   t o   l u d i c r o u s   v a l u e  
 / / - - -   h a n d l e s  
 i n t 	 	 	 	 g _ h a n d l e A t r   =   0 ;  
 / / - - -   a r r a y s  
 M q l R a t e s 	 	 	 g _ r a t e s [ ] ;  
 d o u b l e 	 	 	 g _ a t r [ ] ;  
  
 / / - - -   i n p u t   p a r a m e t e r s  
 i n p u t   d o u b l e 	 S L _ A T R _ F A C T O R   =   1 . 7 5 ; 	 	 	 / /   A T R   F a c t o r   t o   d e t e r m i n e   d i s t a n c e   t o   p l a c e   S L  
 i n p u t   i n t 	 	 A R _ F I X E D _ T R A I L I N G _ P T S   =   2 7 0 0 ; 	 / /   M a x   p o i n t s   t o   k e e p   S L   f r o m   p r i c e s   w h i l e   t r a i l i n g  
 i n p u t   i n t 	 	 I n p A t r P e r i o d   =   1 4 ; 	 	 	 	 / /   A T R   P e r i o d  
  
 / / - - -   c o n s t a n t s  
 c o n s t   l o n g 	 	 M A G I C _ N U M B E R   =   5 6 7 8 9 0 0 ;  
 c o n s t   d o u b l e 	 T R A D E _ V O L U M E   =   0 . 1 0 ; 	 	 	 	 / /   F o r   s t r a t e g y   d e v e l o p m e n t ,   f i x e d   l o t   s i z e   o f   0 . 1 0   i s   g o o d  
 c o n s t   i n t 	 	 C H A R T _ I D   =   0 ; 	 	 	 	 	 	 / /   C u r r e n t   c h a r t  
 c o n s t   i n t 	 	 S U B _ W I N D O W   =   0 ; 	 	 	 	 	 / /   M a i n   W i n d o w  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   E x p e r t   i n i t i a l i z a t i o n   f u n c t i o n                                                                       |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
  
 v o i d   O n S t a r t ( )  
     {  
       d o u b l e   A s k   =   N o r m a l i z e D o u b l e ( S y m b o l I n f o D o u b l e ( _ S y m b o l , S Y M B O L _ A S K ) , _ D i g i t s ) ;  
       d o u b l e   B i d   =   N o r m a l i z e D o u b l e ( S y m b o l I n f o D o u b l e ( _ S y m b o l , S Y M B O L _ B I D ) , _ D i g i t s ) ;  
 P r i n t ( " A S K   " , A s k , "   " , B i d ) ;  
        
       i n t       c b = 0 , c s = 0 ;  
       f o r ( i n t   i = P o s i t i o n s T o t a l ( ) - 1 ; i > = 0 ; i - - )  
             {  
             s t r i n g   s y m b o l   =   P o s i t i o n G e t S y m b o l ( i ) ;  
             u l o n g   P o s i t i o n T i c k e t = P o s i t i o n G e t I n t e g e r ( P O S I T I O N _ T I C K E T ) ;  
             d o u b l e   C u r r e n t P r i c e = P o s i t i o n G e t D o u b l e ( P O S I T I O N _ P R I C E _ O P E N ) ;  
             d o u b l e   C u r r e n t S t o p L o s s = P o s i t i o n G e t D o u b l e ( P O S I T I O N _ S L ) ;  
             d o u b l e   C u r r e n t T r a g e t = P o s i t i o n G e t D o u b l e ( P O S I T I O N _ T P ) ;  
             s t r i n g   T i c k e t = E n u m T o S t r i n g ( E N U M _ P O S I T I O N _ T Y P E ( P o s i t i o n G e t I n t e g e r ( P O S I T I O N _ T I C K E T ) ) ) ;  
             s t r i n g   P o s i t i o n T y p e = E n u m T o S t r i n g ( E N U M _ P O S I T I O N _ T Y P E ( P o s i t i o n G e t I n t e g e r ( P O S I T I O N _ T Y P E ) ) ) ;  
             i f   ( S t r i n g S u b s t r ( P o s i t i o n T y p e , 1 4 ) = = " S E L L " )  
                   {  
                   c s = c s + 1 ;  
                   }  
             i f   ( S t r i n g S u b s t r ( P o s i t i o n T y p e , 1 4 ) = = " B U Y " )  
                   {  
                   c b = c b + 1 ;  
                   }  
             }  
 P r i n t ( " N u m b e r   O r d e r = " , P o s i t i o n s T o t a l ( ) , "   O r d e r   B u y = " , c b , "   O r d e r   S e l l = " , c s ) ;                    
              
             d o u b l e   U p p e r B a n d A r r a y [ ] ;  
             d o u b l e   L o w e r B a n d A r r a y [ ] ;  
             d o u b l e   M i d d l e B a n d A r r a y [ ] ;  
        
             A r r a y S e t A s S e r i e s ( U p p e r B a n d A r r a y , t r u e ) ;  
             A r r a y S e t A s S e r i e s ( L o w e r B a n d A r r a y , t r u e ) ;  
             A r r a y S e t A s S e r i e s ( M i d d l e B a n d A r r a y , t r u e ) ;  
        
             i n t   B o l l i n g e r B a n d s D e f i n i t i o n = i B a n d s ( _ S y m b o l , _ P e r i o d , 1 0 0 , 0 , 2 , P R I C E _ C L O S E ) ;  
                  
             C o p y B u f f e r ( B o l l i n g e r B a n d s D e f i n i t i o n , 1 , 0 , 1 0 0 , U p p e r B a n d A r r a y ) ;  
             C o p y B u f f e r ( B o l l i n g e r B a n d s D e f i n i t i o n , 2 , 0 , 1 0 0 , L o w e r B a n d A r r a y ) ;  
             C o p y B u f f e r ( B o l l i n g e r B a n d s D e f i n i t i o n , 0 , 0 , 1 0 0 , M i d d l e B a n d A r r a y ) ;  
              
             i n t   B B T o t a l   =   A r r a y S i z e ( U p p e r B a n d A r r a y ) ;  
 P r i n t ( B B T o t a l ) ;                    
             d o u b l e   M y U p p e r B a n d V a l u e = U p p e r B a n d A r r a y [ 0 ] ;  
             d o u b l e   M y L o w e r B a n d V a l u e = L o w e r B a n d A r r a y [ 0 ] ;  
             d o u b l e   M y M i d d l e B a n d V a l u e = M i d d l e B a n d A r r a y [ 0 ] ;  
 P r i n t ( " B B   " , ( U p p e r B a n d A r r a y [ 0 ] - L o w e r B a n d A r r a y [ 0 ] ) / 2 , "   " , ( U p p e r B a n d A r r a y [ 0 ] - M i d d l e B a n d A r r a y [ 0 ] ) , "   " , M i d d l e B a n d A r r a y [ 0 ] ) ;              
  
             d a t e t i m e   d a t e 1 = D ' 2 0 2 0 . 1 1 . 1 5   0 0 : 0 0 : 0 0 ' ;    
             d a t e t i m e   d a t e 2 = D ' 2 0 2 0 . 1 1 . 2 8   2 3 : 5 9 : 0 0 ' ;  
             M q l R a t e s   P r i c e I n f o [ ] ;  
             A r r a y S e t A s S e r i e s ( P r i c e I n f o , t r u e ) ;  
             i n t   D a t a = C o p y R a t e s ( S y m b o l ( ) , P e r i o d ( ) , d a t e 1 , d a t e 2 , P r i c e I n f o ) ;  
              
 P r i n t ( " A T R { 0 }   " , ( P r i c e I n f o [ 1 ] . h i g h - P r i c e I n f o [ 1 ] . l o w ) , 4 ) ;  
  
             d o u b l e                   A T R B u f f e r [ ] ;    
        
             A r r a y S e t A s S e r i e s ( A T R B u f f e r , t r u e ) ;  
          
             i n t   A T R d e f i n i t i o n   =   i A T R ( _ S y m b o l , _ P e r i o d , 1 4 ) ;  
        
             C o p y B u f f e r ( A T R d e f i n i t i o n , 0 , 0 , 4 , A T R B u f f e r ) ;  
        
             d o u b l e       M y A T R V a l u e 0   =   A T R B u f f e r [ 0 ] ;    
              
        
 P r i n t ( " A T R [ 1 4 ]   " , M y A T R V a l u e 0 , "   " , ( P r i c e I n f o [ 1 ] . h i g h - P r i c e I n f o [ 1 ] . l o w ) / M y A T R V a l u e 0 * 1 0 0 , "   " , M y A T R V a l u e 0 / ( U p p e r B a n d A r r a y [ 0 ] - L o w e r B a n d A r r a y [ 0 ] ) * 1 0 0 ) ;  
  
  
             d o u b l e                   M A C D B u f f e r [ ] ;    
             d o u b l e                   S i g n a l B u f f e r [ ] ;  
        
        
             A r r a y S e t A s S e r i e s ( M A C D B u f f e r , t r u e ) ;  
             A r r a y S e t A s S e r i e s ( S i g n a l B u f f e r , t r u e ) ;  
        
          
             i n t   M A C D d e f i n i t i o n   =   i M A C D ( _ S y m b o l , _ P e r i o d , 6 , 1 1 , 9 , P R I C E _ C L O S E ) ;  
        
             C o p y B u f f e r ( M A C D d e f i n i t i o n , 0 , 0 , 4 , M A C D B u f f e r ) ;  
             C o p y B u f f e r ( M A C D d e f i n i t i o n , 1 , 0 , 4 , S i g n a l B u f f e r ) ;  
        
             d o u b l e       M y M A C D V a l u e 0   =   M A C D B u f f e r [ 0 ] ;    
             d o u b l e       M y S i g n a l V a l u e 0   =   S i g n a l B u f f e r [ 0 ] ;  
             d o u b l e       M y M A C D V a l u e 1   =   M A C D B u f f e r [ 1 ] ;    
             d o u b l e       M y S i g n a l V a l u e 1   =   S i g n a l B u f f e r [ 1 ] ;  
             d o u b l e       M y M A C D V a l u e 2   =   M A C D B u f f e r [ 2 ] ;    
             d o u b l e       M y S i g n a l V a l u e 2   =   S i g n a l B u f f e r [ 2 ] ;  
             d o u b l e       M y M A C D V a l u e 3   =   M A C D B u f f e r [ 3 ] ;    
             d o u b l e       M y S i g n a l V a l u e 3   =   S i g n a l B u f f e r [ 3 ] ;  
        
 P r i n t ( " M A C D   " , M y M A C D V a l u e 0 ) ;  
              
  
     }  
 i n t   O n I n i t ( )  
     {  
 / / - - -  
 / /       g _ t r a d e . S e t E x p e r t M a g i c N u m b e r ( M A G I C _ N U M B E R ) ;  
  
       g _ p o i n t S i z e   =   S y m b o l I n f o D o u b l e ( _ S y m b o l ,   S Y M B O L _ P O I N T ) ;  
       P r i n t F o r m a t ( " g _ p o i n t S i z e   i s   [ % . 5 f ] " ,   g _ p o i n t S i z e ) ;  
  
 / / - - -   A T R  
       g _ h a n d l e A t r   =   i A T R ( _ S y m b o l , 	 	 	 / /   s y m b o l  
                                             _ P e r i o d , 	 	 	 / /   p e r i o d  
                                             I n p A t r P e r i o d ) ; 	 / /   a t r _ p e r i o d  
       i f ( g _ h a n d l e A t r   = =   I N V A L I D _ H A N D L E )  
           {  
             P r i n t F o r m a t ( " % s ( ) :   E r r o r   c r e a t i n g   i A T R   i n d i c a t o r   h a n d l e   f o r   [ % s ]   [ % d ] " ,   _ S y m b o l ,   _ P e r i o d ) ;  
             r e t u r n   I N I T _ F A I L E D ;  
           }  
  
       A r r a y R e s i z e ( g _ r a t e s ,   N U M _ R A T E S ) ;  
       A r r a y S e t A s S e r i e s ( g _ r a t e s ,   t r u e ) ;  
       A r r a y R e s i z e ( g _ a t r ,   N U M _ R A T E S ) ;  
       A r r a y S e t A s S e r i e s ( g _ a t r ,   t r u e ) ;  
  
 / / - - -   o k  
       P r i n t ( " I N I T _ S U C C E E D E D   f o r   E A ! " ) ;  
 / / - - -  
       r e t u r n ( I N I T _ S U C C E E D E D ) ;  
     }  
 v o i d   O n T i c k ( )  
     {  
       d o u b l e   A s k   =   N o r m a l i z e D o u b l e ( S y m b o l I n f o D o u b l e ( _ S y m b o l , S Y M B O L _ A S K ) , _ D i g i t s ) ;  
       d o u b l e   B i d   =   N o r m a l i z e D o u b l e ( S y m b o l I n f o D o u b l e ( _ S y m b o l , S Y M B O L _ B I D ) , _ D i g i t s ) ;  
 P r i n t ( " A S K   " , A s k , "   " , B i d ) ;  
 / / - - -   B a r   l e v e l   f u n c t i o n a l i t y  
       i f ( I s N e w B a r ( _ S y m b o l ,   _ P e r i o d ) )  
           {  
             / / - - -   N e e d   d a t a   o r   w e ' v e   g o t   n o t h i n g  
             i f ( !   R e f r e s h D a t a ( ) )  
                 {  
                   P r i n t ( " C o u l d n ' t   r e f r e s h   d a t a " ) ;  
                   r e t u r n ;  
                 }  
  
             / / - - -   S e e   i f   a   p o s i t i o n   i s   a l r e a d y   o p e n  
             i f ( S e l e c t P o s i t i o n ( _ S y m b o l ,   M A G I C _ N U M B E R ) )  
                 {  
                   / /   P o s i t i o n   i s   o p e n ,   s o   a d j u s t   r i s k   a s   n e c e s s a r y  
                   F i x e d T r a i l i n g S t o p ( ) ;  
                 }  
             e l s e  
                 {  
                   / / - - -   N o   p o s i t i o n   o p e n ,   s o   l o o k   f o r   s i g n a l  
 / /                   C h e c k F o r O p e n S i g n a l ( ) ;  
                 }  
  
             / / - - -   D r a w   e v e r y   D o j i   w h e t h e r   w e   p l a c e   a   t r a d e   o r   n o t  
 / /             i f ( I s D o j i ( g _ r a t e s [ 1 ] ) )  
                 {  
 / /                   D r a w A r r o w ( g _ r a t e s [ 1 ] . t i m e ,   g _ r a t e s [ 1 ] . l o w   -   . 3 3 3   *   g _ a t r [ 1 ] ,   A R R O W _ U P ,   Y e l l o w ,   " D o j i " ) ;  
                 }  
           }        
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 b o o l   I s N e w B a r ( c o n s t   s t r i n g   s y m b o l ,   c o n s t   E N U M _ T I M E F R A M E S   p e r i o d )  
     {  
       b o o l   i s N e w B a r   =   f a l s e ;  
       s t a t i c   d a t e t i m e   p r i o r B a r O p e n T i m e   =   N U L L ;  
  
 / / - - -   S E R I E S _ L A S T B A R _ D A T E   = =   O p e n   t i m e   o f   t h e   l a s t   b a r   o f   t h e   s y m b o l - p e r i o d  
       c o n s t   d a t e t i m e   c u r r e n t B a r O p e n T i m e   =   ( d a t e t i m e )   S e r i e s I n f o I n t e g e r ( s y m b o l ,   p e r i o d ,   S E R I E S _ L A S T B A R _ D A T E ) ;  
  
       i f ( p r i o r B a r O p e n T i m e   ! =   c u r r e n t B a r O p e n T i m e )  
           {  
             / / - - -   D o n ' t   w a n t   n e w   b a r   j u s t   b e c a u s e   E A   s t a r t e d  
             i s N e w B a r   =   ( p r i o r B a r O p e n T i m e   = =   N U L L )   ?   f a l s e   :   t r u e ; 	 / /   p r i o r B a r O p e n T i m e   i s   o n l y   N U L L   o n c e  
  
             / / - - -   R e g a r d l e s s   o f   n e w   b a r ,   u p d a t e   t h e   h e l d   b a r   t i m e  
             p r i o r B a r O p e n T i m e   =   c u r r e n t B a r O p e n T i m e ;  
           }  
 P r i n t ( c u r r e n t B a r O p e n T i m e , "   " , p r i o r B a r O p e n T i m e ) ;  
       r e t u r n   i s N e w B a r ;  
     }  
 b o o l   R e f r e s h D a t a ( v o i d )  
     {  
 / / - - -   g o   t r a d i n g   o n l y   f o r   f i r s t   t i c k s   o f   n e w   b a r  
       i f ( C o p y R a t e s ( _ S y m b o l ,   _ P e r i o d ,   0 ,   N U M _ R A T E S ,   g _ r a t e s )   ! =   N U M _ R A T E S )  
           {  
             P r i n t ( " C o p y R a t e s   o f   " ,   _ S y m b o l ,   "   f a i l e d ,   n o   h i s t o r y " ) ;  
             r e t u r n   f a l s e ;  
           }  
  
 / / - - -   g e t   c u r r e n t   A T R  
       i f ( g _ h a n d l e A t r   ! =   I N V A L I D _ H A N D L E )  
           {  
             i f ( C o p y B u f f e r ( g _ h a n d l e A t r ,   0 ,   0 ,   N U M _ R A T E S ,   g _ a t r )   ! =   N U M _ R A T E S )  
                 {  
                   P r i n t ( " C o p y B u f f e r   f r o m   i A T R   f a i l e d ,   n o   d a t a " ) ;  
                   r e t u r n   f a l s e ;  
                 }  
           }  
  
       r e t u r n   t r u e ;  
     }  
  
 b o o l   S e l e c t P o s i t i o n ( c o n s t   s t r i n g   s y m b o l ,   c o n s t   u l o n g   m a g i c N u m b e r )  
     {  
 / / - - -   D o   w e   h a v e   a n   o p e n   p o s i t i o n ?  
       i f ( ! P o s i t i o n S e l e c t ( s y m b o l ) )  
           {  
             / / - - -   N o   p o s i t i o n   i s   o p e n   f o r   t h i s   s y m b o l  
             r e t u r n   f a l s e ;  
           }  
       e l s e  
           {  
             / / - - -   W e   f o u n d   a   p o s i t i o n   f o r   t h i s   s y m b o l ,   b u t   i s   i t   o n e   o f   o u r s ?  
             r e t u r n ( P o s i t i o n G e t I n t e g e r ( P O S I T I O N _ M A G I C )   = =   m a g i c N u m b e r ) ;  
           }  
  
       r e t u r n   f a l s e ;  
     }  
  
 b o o l   F i x e d T r a i l i n g S t o p ( v o i d )  
     {  
       C P o s i t i o n I n f o 	 g _ p o s i t i o n I n f o ; 	 	 	 / /   M Q L   s t a n d a r d   l i b r a r y   f o r   p o s i t i o n s  
       d o u b l e 	 	 	 s l D P t s   =   0 . ; 	 	 	 / /   S L   d i s t a n c e   p o i n t s  
       d o u b l e 	 	 	 p l D P t s   =   0 . ; 	 	 	 / /   P r o f i t / L o s s   d i s t a n c e   p o i n t s  
  
 / / - - -   G e t   t h e   s t e p   a m o u n t .  
 / / - - -   T h i s   s o r t   o f   a s s u m e s   t h a t   t h e   o r i g i n a l   S L   w a s   s e t   a t   N * A T R   i n   t h e   f i r s t   p l a c e ;  
 / / - - -   o t h e r w i s e ,   y o u   w i l l   g e t   a   b i g   j u m p   t h e   f i r s t   t i m e ,   o r   i t   w o n ' t   m o v e   a t   a l l .  
       c o n s t   d o u b l e   f i x e d D P t s   =   A R _ F I X E D _ T R A I L I N G _ P T S   *   g _ p o i n t S i z e ;  
  
       d o u b l e   p r i c e   =   0 . ; 	 	 	 	 	 	 	 / /   C u r r e n t   p r i c e   ( A S K   o r   B I D )  
       c o n s t   d o u b l e   o p e n   =   g _ p o s i t i o n I n f o . P r i c e O p e n ( ) ;  
       c o n s t   d o u b l e   s l   =   g _ p o s i t i o n I n f o . S t o p L o s s ( ) ;  
       c o n s t   E N U M _ P O S I T I O N _ T Y P E   p o s i t i o n T y p e   =   g _ p o s i t i o n I n f o . P o s i t i o n T y p e ( ) ;  
  
       s w i t c h ( p o s i t i o n T y p e )  
           {  
             c a s e   P O S I T I O N _ T Y P E _ B U Y :  
                   p r i c e   =   S y m b o l I n f o D o u b l e ( _ S y m b o l ,   S Y M B O L _ B I D ) ;  
                   s l D P t s   =   p r i c e   -   s l ;  
                   p l D P t s   =   p r i c e   -   o p e n ; 	 	 / /   P r o f i t   L o s s   i s   d e t e r m i n e d   f r o m   t h e   o p e n  
                   b r e a k ;  
             c a s e   P O S I T I O N _ T Y P E _ S E L L :  
                   p r i c e   =   S y m b o l I n f o D o u b l e ( _ S y m b o l ,   S Y M B O L _ A S K ) ;  
                   s l D P t s   =   s l   -   p r i c e ;  
                   p l D P t s   =   o p e n   -   p r i c e ;  
                   b r e a k ;  
             d e f a u l t :  
                   P r i n t F o r m a t ( " U n k n o w n   p o s i t i o n   t y p e   [ % s ] " ,   E n u m T o S t r i n g ( p o s i t i o n T y p e ) ) ;  
                   E x p e r t R e m o v e ( ) ;  
           }  
  
 / / - - -   I s   t h e   d i s t a n c e   f r o m   s l D P t s   ( p r i c e   t o   S L )   g r e a t e r   t h a n   t h e   t r a i l i n g   A T R   d i s t a n c e ?  
       i f ( s l D P t s   >   f i x e d D P t s )  
           {  
             / / - - -   N e v e r   m o v e   S L   w h e n   u n p r o f i t a b l e ,   e . g .   l o w e r   v o l a t i l i t y .  
             c o n s t   d o u b l e   s p r e a d   =   ( d o u b l e )   S y m b o l I n f o I n t e g e r ( _ S y m b o l ,   S Y M B O L _ S P R E A D )   *   g _ p o i n t S i z e ;  
             i f ( p l D P t s   <   s p r e a d )  
                 {  
                   / /   n o t   p r o f i t a b l e  
                   r e t u r n   f a l s e ;  
                 }  
  
             d o u b l e   n e w S L   =   - 1 . ; 	 	 / /   S t a r t   w i t h   r i d i c u l o u s   v a l u e  
             s w i t c h ( p o s i t i o n T y p e )  
                 {  
                   c a s e   P O S I T I O N _ T Y P E _ B U Y :  
                         n e w S L   =   g _ r a t e s [ 1 ] . c l o s e   -   f i x e d D P t s ;  
                         b r e a k ;  
                   c a s e   P O S I T I O N _ T Y P E _ S E L L :  
                         n e w S L   =   g _ r a t e s [ 1 ] . c l o s e   +   f i x e d D P t s ;  
                         b r e a k ;  
                   d e f a u l t :  
                         P r i n t F o r m a t ( " U n k n o w n   p o s i t i o n   t y p e   [ % s ] " ,   E n u m T o S t r i n g ( p o s i t i o n T y p e ) ) ;  
                         E x p e r t R e m o v e ( ) ;  
                 }  
  
             / / - - -   D o n ' t   r e q u e s t   a   m o v e   i f   t h e   n e w   S L   i s   e s s e n t i a l l y   t h e   s a m e   a s   t h e   o l d   o n e .  
             i f ( M a t h A b s ( n e w S L   -   s l )   <   g _ p o i n t S i z e )  
                 {  
                   r e t u r n   f a l s e ;  
                 }  
  
             / / - - -   M o v e   S L   a b s o l u t e  
             b o o l   m o d i f i e d   =   P o s i t i o n M o d i f y ( g _ t r a d e ,   g _ p o s i t i o n I n f o ,   _ S y m b o l ,   n e w S L ,   N U L L ) ;  
             i f ( m o d i f i e d )  
                 {  
 / /                   D r a w L i n e ( n e w S L ,   R e d ) ;  
 P r i n t ( " " ) ;  
                 }  
             r e t u r n   m o d i f i e d ;  
           }  
       r e t u r n   f a l s e ;  
     }  
  
 b o o l   P o s i t i o n M o d i f y ( C T r a d e &   t r a d e ,  
                                         C P o s i t i o n I n f o &   p o s i t i o n ,  
                                         c o n s t   s t r i n g   s y m b o l ,  
                                         c o n s t   d o u b l e   s l ,  
                                         d o u b l e   t p   =   N U L L )  
     {  
  
 / / - - -   a d d i t i o n a l   c h e c k i n g  
       i f ( !   T e r m i n a l I n f o I n t e g e r ( T E R M I N A L _ T R A D E _ A L L O W E D ) )  
           {  
             P r i n t F o r m a t ( " % s ( % s ) :   E r r o r   [ T E R M I N A L _ T R A D E _ A L L O W E D ] " ,   _ _ F U N C T I O N _ _ ,   s y m b o l ) ;  
             r e t u r n   f a l s e ;  
           }  
  
       c o n s t   E N U M _ P O S I T I O N _ T Y P E   p o s i t i o n T y p e   =   p o s i t i o n . P o s i t i o n T y p e ( ) ;  
       c o n s t   d o u b l e   p r i c e   =   p o s i t i o n . P r i c e O p e n ( ) ;  
       i f ( t p   = =   N U L L )  
           {  
             t p   =   p o s i t i o n . T a k e P r o f i t ( ) ;  
           }  
  
 / / - - -   E n s u r e   T P   a n d   S L   m e e t   m i n i m u m   s e r v e r   l e v e l s .  
       c o n s t   E N U M _ O R D E R _ T Y P E   o r d e r T y p e   =   ( p o s i t i o n T y p e   = =   P O S I T I O N _ T Y P E _ B U Y )   ?   O R D E R _ T Y P E _ B U Y   :   O R D E R _ T Y P E _ S E L L ;  
 / /       i f ( !   C h e c k S t o p s L e v e l ( o r d e r T y p e ,   s y m b o l ,   p r i c e ,   s l ) )  
           {  
             r e t u r n   f a l s e ;  
           }  
  
 / / - - -   D o   a   b r o k e r   m o d i f y  
       b o o l   m o d i f i e d   =   t r a d e . P o s i t i o n M o d i f y ( s y m b o l ,   s l ,   t p ) ;  
       i f ( ! m o d i f i e d )  
           {  
             P r i n t F o r m a t ( " % s ( % s )   E r r o r :   R e t c o d e   [ % d ]   :   ' % s ' " ,   _ _ F U N C T I O N _ _ ,   s y m b o l ,   t r a d e . R e s u l t R e t c o d e ( ) ,   t r a d e . R e s u l t C o m m e n t ( ) ) ;  
             r e t u r n   f a l s e ;  
           }  
  
       r e t u r n   t r u e ;  
     } 