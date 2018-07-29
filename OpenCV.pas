    (*********************************************************************
     *                                                                   *
     *  Borland Delphi 4,5,6,7 API for                                   *
     *  Intel Open Source Computer Vision Library                        *
     *                                                                   *
     *                                                                   *
     *  Portions created by Intel Corporation are                        *
     *  Copyright (C) 2000, Intel Corporation, all rights reserved.      *
     *                                                                   *
     *  The original files are: CV.h, CVTypes.h, highgui.h               *        
     *                                                                   *
     *                                                                   *
     *  The original Pascal code is: OpenCV.pas,  released 29 May 2003.  *
     *                                                                   *
     *  The initial developer of the Pascal code is Vladimir Vasilyev    *        
     *                  home page : http://www.nextnow.com               *
     *                  email     : Vladimir@nextnow.com                 *
     *                              W-develop@mtu-net.ru                 *
     *                                                                   *
     *  Contributors: Andrey Klimov                                      *
     *********************************************************************
     *  Expanded version to use many other functions                     *
     *  G. De Sanctis - 9/2005                                           *
     *  1/2012 - "$define V2"  use OpenCV 2.3 Dll, else use old OpenCV 1 *
     *    style Dll                                                      *
     *  5/2012 - added types CvChar and PCvChar to force AnsiChar type   *
     *    (8 bit characters) in Delphi XE2                               *
     *  9/2012 - added symbols for use in FreePascal with MSEGui or      *
     *  Lazarus                                                          *
     *  9/2012 - added symbols for use in Linux with FreePascal          *
     *                                                                   *
     *  3/2016 - J.P "$define V3"  use OpenCV 3.0 Dll                    *
     *  disable MSEGUI to use with Lazarus                               *
     *  4/2016 - zbyna several fixes for fpc 64 bit. compiler            *
     *         - added remainig utilities from HighGUI_DLL               *
     *         - fix possibility to use "$define V2" in case of camera   *
     *           incompatibility ( lifecam 6000HD ...  )                 *
     *         - fix for 'Not a 24 bit color iplImage!'                  *
     *           in IplImage2Bitmap                                      *
     *  7/2018 - Modified by t-edson:
               - Remove support MSEGUI, to simplify.
               - Adapted to work with Lazarus in  Limux and Windows

     *********************************************************************
     *                                                                   *
     *                                                                   *
     *  The contents of this file are used with permission, subject to   *
     *  the Mozilla Public License Version 1.1 (the "License"); you may  *
     *  not use this file except in compliance with the License. You may *
     *  obtain a copy of the License at                                  *
     *  http://www.mozilla.org/MPL/MPL-1.1.html                          *
     *                                                                   *
     *  Software distributed under the License is distributed on an      *
     *  "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   *
     *  implied. See the License for the specific language governing     *
     *  rights and limitations under the License.                        *
     *                                                                   *
     *********************************************************************)


unit OpenCV;

{set here the OpenCV version}
{$define V2}

{$ifdef FPC}
  {$mode delphi}
  {$ifdef LCL}
    {$define LAZARUS}
  {$endif}
{$endif}


{$A+,Z+}
{$ASSERTIONS on}


interface

uses
{$ifdef MSWINDOWS}
  Windows,
{$endif}  
{$ifdef FPC}
    {$ifdef LAZARUS}
     Graphics, FPImage, IntfGraphics, GraphType,
    {$endif}
{$else}
  Graphics,
{$endif}
  Sysutils,Math,
  IPL;

const
{$ifdef MSWINDOWS}
{$ifdef V3}
 cvDLL       = 'opencv_world300.dll';
 videoDLL    = 'opencv_world300.dll';
 calibDLL    = 'opencv_world300.dll';
 HighGUI_DLL = 'opencv_world300.dll';
 cxCore      = 'opencv_world300.dll';
 cvCam       = 'opencv_world300.dll';

{$else}
{$ifdef V2}
 cvDLL       = 'opencv_imgproc2413.dll';
 videoDLL    = 'opencv_video2413.dll';
 calibDLL    = 'opencv_calib3d2413.dll';
 HighGUI_DLL = 'opencv_highgui2413.dll';
 cxCore      = 'opencv_core2413.dll';
 legacyDLL   = 'opencv_legacy2413.dll';
 objdetect_lib='opencv_objdetect2413.dll';
{$else}
 cvDLL       = 'CV100.DLL';
 videoDLL    = 'CV100.DLL';
 calibDLL    = 'CV100.DLL';
 HighGUI_DLL = 'HighGUI100.DLL';
 cxCore      = 'CXCORE100.DLL';
 cvCam       = 'CVCAM100.DLL';
{$endif}
{$endif}
{$endif}

{$ifdef LINUX} 
{$ifdef V2}
 cvDLL       = 'libopencv_imgproc.so.2.4.9';
 videoDLL    = 'libopencv_video.so.2.4.9';
 calibDLL    = 'libopencv_calib3d.so.2.4.9';
 HighGUI_DLL = 'libopencv_highgui.so.2.4.9';
 cxCore      = 'libopencv_core.so.2.4.9';
 legacyDLL   = 'libopencv_legacy.so.2.4.9';
 objdetect_lib='libopencv_objdetect.so.2.4.9';
{$else}
 cvDLL       = '???';
 videoDLL    = '???';
 calibDLL    = '???';
 HighGUI_DLL = '???';
 cxCore      = '???';
 cvCam       = '???';
{$endif}
{$endif}



 CV_32F = 5;
 //CV_32FC1 = CV_32F + 0*8;

 CV_MAT_TYPE_MASK = 511;
 CV_MAT_MAGIC_VAL = $42420000;
 CV_MAT_CONT_FLAG_SHIFT = 14;
 CV_MAT_CONT_FLAG = 1 shl CV_MAT_CONT_FLAG_SHIFT;

 CV_MAT_CN_MASK = 3 shl 3;
 CV_MAT_DEPTH_MASK = 7;


 CV_RODRIGUES_M2V = 0;
 CV_RODRIGUES_V2M = 1;


 CV_LU  = 0;
 CV_SVD = 1;


{ Constants for color conversion }
        CV_BGR2BGRA   =0;
        CV_RGB2RGBA   =CV_BGR2BGRA;

        CV_BGRA2BGR   =1;
        CV_RGBA2RGB   =CV_BGRA2BGR;

        CV_BGR2RGBA   =2;
        CV_RGB2BGRA   =CV_BGR2RGBA;

        CV_RGBA2BGR   =3;
        CV_BGRA2RGB   =CV_RGBA2BGR;

        CV_BGR2RGB    =4;
        CV_RGB2BGR    =CV_BGR2RGB;

        CV_BGRA2RGBA  =5;
        CV_RGBA2BGRA  =CV_BGRA2RGBA;

        CV_BGR2GRAY   =6;
        CV_RGB2GRAY   =7;
        CV_GRAY2BGR   =8;
        CV_GRAY2RGB   =CV_GRAY2BGR;
        CV_GRAY2BGRA  =9;
        CV_GRAY2RGBA  =CV_GRAY2BGRA;
        CV_BGRA2GRAY  =10;
        CV_RGBA2GRAY  =11;

        CV_BGR2BGR565 =12;
        CV_RGB2BGR565 =13;
        CV_BGR5652BGR =14;
        CV_BGR5652RGB =15;
        CV_BGRA2BGR565=16;
        CV_RGBA2BGR565=17;
        CV_BGR5652BGRA=18;
        CV_BGR5652RGBA=19;

        CV_GRAY2BGR565=20;
        CV_BGR5652GRAY=21;

        CV_BGR2BGR555 =22;
        CV_RGB2BGR555 =23;
        CV_BGR5552BGR =24;
        CV_BGR5552RGB =25;
        CV_BGRA2BGR555=26;
        CV_RGBA2BGR555=27;
        CV_BGR5552BGRA=28;
        CV_BGR5552RGBA=29;

        CV_GRAY2BGR555=30;
        CV_BGR5552GRAY=31;

        CV_BGR2XYZ    =32;
        CV_RGB2XYZ    =33;
        CV_XYZ2BGR    =34;
        CV_XYZ2RGB    =35;

        CV_BGR2YCrCb  =36;
        CV_RGB2YCrCb  =37;
        CV_YCrCb2BGR  =38;
        CV_YCrCb2RGB  =39;

        CV_BGR2HSV    =40;
        CV_RGB2HSV    =41;

        CV_BGR2Lab    =44;
        CV_RGB2Lab    =45;

        CV_BayerBG2BGR=46;
        CV_BayerGB2BGR=47;
        CV_BayerRG2BGR=48;
        CV_BayerGR2BGR=49;

        CV_BayerBG2RGB=CV_BayerRG2BGR;
        CV_BayerGB2RGB=CV_BayerGR2BGR;
        CV_BayerRG2RGB=CV_BayerBG2BGR;
        CV_BayerGR2RGB=CV_BayerGB2BGR;

        CV_BGR2Luv    =50;
        CV_RGB2Luv    =51;
        CV_BGR2HLS    =52;
        CV_RGB2HLS    =53;

        CV_HSV2BGR    =54;
        CV_HSV2RGB    =55;

        CV_Lab2BGR    =56;
        CV_Lab2RGB    =57;
        CV_Luv2BGR    =58;
        CV_Luv2RGB    =59;
        CV_HLS2BGR    =60;
        CV_HLS2RGB    =61;




 CV_FILLED = -(1);
 CV_AA = 16;

type
// Delphi XE2 fix
  CvChar = AnsiChar;
  PCvChar = PAnsiChar;
  TpCVCharArray = array [0 .. 0] of pCVChar;  // by Zbyna
  ppCVChar = ^TpCVCharArray;                  // by zbyna
//--------------

  UCHAR  = {$IFDEF WINDOWS} Windows.UCHAR  {$ELSE}  Byte {$ENDIF};
  PUCHAR = {$IFDEF WINDOWS} Windows.PUCHAR {$ELSE} ^Byte {$ENDIF};
  PINT   = {$IFDEF WINDOWS} Windows.PINT   {$ELSE} ^integer {$ENDIF};


  PCvVect32f = PSingle;
  TCvVect32fArr=array of Single;

  PCvMatr32f = PSingle;
  TCvMatr32fArr=array of Single;

  TIntegerArr=array of Integer;


  TCvSize = record
            width  : longint;
            height : longint;
           end;
  PCvSize = ^TCvSize;

  CvPoint2D32f = record
                    x : Single;
                    y : Single;
                 end;
  TCvPoint2D32f = CvPoint2D32f;
  PCvPoint2D32f = ^TCvPoint2D32f;
  TCvPoint2D32fArr=array of TCvPoint2D32f;


  CvPoint3D32f = record
                    x : Single;
                    y : Single;
                    z : Single;
                 end;
  TCvPoint3D32f = CvPoint3D32f;
  PCvPoint3D32f = ^TCvPoint3D32f;
  TCvPoint3D32fArr=array of TCvPoint3D32f;

  TMatData = record
               ptr: PUCHAR;
             end;

  CvMat = record
            type_       : Integer;
            step        : Integer;
            refcount    : PInteger;
            hdr_refcount: {$ifdef CPU64}int64{$else}integer{$endif};
            data        : TMatData;
            rows        : Integer;
            cols        : Integer;
          end;
  TCvMat = CvMat;
  PCvMat = ^TCvMat;
  P2PCvMat = ^PCvMat;

    { CvArr* is used to pass arbitrary array-like data structures
     into the functions where the particular
     array type is recognized at runtime  }
    // CvArr = void;
  PCvArr = Pointer;
  P2PCvArr = ^PCvArr;

//****************************************************************************************\
//*                       Multi-dimensional dense array (CvMatND)                          *
//****************************************************************************************/
  const
     CV_MATND_MAGIC_VAL = $42430000;
     CV_TYPE_NAME_MATND = 'opencv-nd-matrix';     
     CV_MAX_DIM = 32;     
     CV_MAX_DIM_HEAP = 1 shl 16;

  type

     CvMatND = record
          _type : longint;
          dims : longint;
          refcount : ^longint;
          data : record
              case longint of
                 0 : ( ptr : ^uchar );
                 1 : ( fl : ^double );
                 2 : ( db : ^double );
                 3 : ( i : ^longint );
                 4 : ( s : ^smallint );
              end;
          dim : array[0..(CV_MAX_DIM)-1] of record
               size : longint;
               step : longint;
            end;
       end;


  {***************************************************************************************\
  *                                         Histogram                                      *
  \*************************************************************************************** }

  type

     CvHistType = longint;

  const
     CV_HIST_MAGIC_VAL = $42450000;
     CV_HIST_UNIFORM_FLAG = 1 shl 10;
  { indicates whether bin ranges are set already or not  }
     CV_HIST_RANGES_FLAG = 1 shl 11;
     CV_HIST_ARRAY = 0;
     CV_HIST_SPARSE = 1;
     CV_HIST_TREE = CV_HIST_SPARSE;
  { should be used as a parameter only,
     it turns to CV_HIST_UNIFORM_FLAG of hist->type  }
     CV_HIST_UNIFORM = 1;
  { for uniform histograms  }
  { for non-uniform histograms  }
  { embedded matrix header for array histograms  }

  type

     CvHistogram = record
          _type : longint;
          bins : PCvArr;
          thresh : array[0..(CV_MAX_DIM)-1] of array[0..1] of float;
          thresh2 : P2Pfloat;
          mat : CvMatND;
       end;
   PCvHistogram = ^CvHistogram;
   P2PCvHistogram = ^PCvHistogram;

//******************************** Memory storage ****************************************/
Type
  PCvMemBlock = ^TCvMemBlock;
  CvMemBlock = Record
                 prev : PCvMemBlock;
                 next : PCvMemBlock;
               end;
  TCvMemBlock = CvMemBlock;

Const CV_STORAGE_MAGIC_VAL = $42890000;

Type
  PCvMemStorage = ^TCvMemStorage;
  CvMemStorage = Record
                   signature : longint;
                   bottom    : PCvMemBlock;   //* first allocated block */
                   top       : PCvMemBlock;   //* current memory block - top of the stack */
                   parent    : PCvMemStorage; //* borrows new blocks from */
                   block_size: longint;       //* block size */
                   free_space: longint;       //* free space in the current block */
                 end; 
  TCvMemStorage = CvMemStorage;



{************************************ CvScalar **************************************** }

     CvScalar = record
          val : array[0..3] of double;
       end;
     PCvScalar = ^CvScalar;
{************************************** CvRect **************************************** }

  type
    pCvRect = ^CvRect;

     CvRect = record
          x : longint;
          y : longint;
          width : longint;
          height : longint;
       end;

 {************************************ CvSlice *****************************************}

type
 CvSlice = record
    start_index: longint;
    end_index  : longint;
 end;



const
    CV_WHOLE_SEQ_END_INDEX = $3fffffff;
var
    CV_WHOLE_SEQ: cvSlice; 


  {********************************** Sequence ****************************************** }
  { previous sequence block  }
  { next sequence block  }
  { index of the first element in the block +
                                   sequence->first->start_index  }
  { number of elements in the block  }
  { pointer to the first element of the block  }

  type

     PCvSeqBlock = ^CvSeqBlock;
     CvSeqBlock = record
          prev : PCvSeqBlock;
          next : PCvSeqBlock;
          start_index : longint;
          count : longint;
          data : puchar;
       end;

     PCvSeq = ^CvSeq;
     P2PCvSeq = ^PCvSeq;
     CvSeq = record
          flags : longint;
          header_size : longint;
          h_prev : PCvSeq;
          h_next : PCvSeq;
          v_prev : PCvSeq;
          v_next : PCvSeq;
          total : longint;
          elem_size : longint;
          block_max : Puchar;
          ptr : Puchar;
          delta_elems : longint;
          storage : PCvMemStorage;
          free_blocks : PCvSeqBlock;
          first : PCvSeqBlock;
       end;



    PCvContour = ^CvContour;
    CvContour = record
        flags: longint;                 //* micsellaneous flags */
        header_size: longint;           //* size of sequence header */
        h_prev: Pcvseq;                 //* previous sequence */
        h_next: Pcvseq;                 //* next sequence */
        v_prev: Pcvseq;                 //* 2nd previous sequence */
        v_next: Pcvseq;                 //* 2nd next sequence */
        total: longint;                 //* total number of elements */
        elem_size: longint;             //* size of sequence element in bytes */
        block_max: PuChar;               //* maximal bound of the last block */
        ptr: PuChar;                     //* current write pointer */
        delta_elems: longint;           //* how many elements allocated when the seq grows */
        storage: PCvMemStorage ;        //* where the seq is stored */
        free_blocks: PCvSeqBlock;       //* free blocks list */
        first: PCvSeqBlock;             //* pointer to the first sequence block */
        rect: CvRect ;
        color: longint;
        reserved: array [0..2] of longint;
    end;

  {*************************** Connected Component  ************************************* }
  { area of the connected component   }
  { average color of the connected component  }
  { ROI of the component   }
  { optional component boundary
           (the contour might have child contours corresponding to the holes) }

     CvConnectedComp = record
          area : double;
          value : CvScalar;
          rect : CvRect;
          contour : PCvSeq;
       end;
     PCvConnectedComp = ^CvConnectedComp;
{****************************** CvPoint and variants ********************************** }

  type

     CvPoint = record
          x : longint;
          y : longint;
       end;
     PCvPoint = ^CvPoint;

     CvPoint2D64f = record
          x : double;
          y : double;
       end;

     CvPoint3D64f = record
          x : double;
          y : double;
          z : double;
       end;

     CvSize2D32f = record
          width : float;
          height : float;
       end;
  { center of the box  }
  { box width and length  }
  { angle between the horizontal axis
                               and the first side (i.e. length) in radians  }

     CvBox2D = record
          center : CvPoint2D32f;
          size : CvSize2D32f;
          angle : float;
       end;
     PCvBox2D = ^CvBox2D;
  { Line iterator state  }
  { pointer to the current point  }
  { Bresenham algorithm state  }

     CvLineIterator = record
          ptr : ^uchar;
          err : longint;
          plus_delta : longint;
          minus_delta : longint;
          plus_step : longint;
          minus_step : longint;
       end;


//*********************************** CvTermCriteria *************************************/
Const
 CV_TERMCRIT_ITER = 1;
 CV_TERMCRIT_NUMB = CV_TERMCRIT_ITER;
 CV_TERMCRIT_EPS  = 2;

Type
  CvTermCriteria  = Record
                      type_   : integer;  { may be combination of CV_TERMCRIT_ITER, CV_TERMCRIT_EPS }
                      maxIter : integer;
                      epsilon : double;
                    end;
  TCvTermCriteria = CvTermCriteria;                  
{\*********************************** CvTermCriteria *************************************}
                    

 Procedure cvRodrigues2( rotMatrix : PCVMAT;
                        rotVector : PCVMAT;
                        jacobian  : PCVMAT;
                        convType  : Integer ); cdecl ;


{ Initializes CvMat header }
const
  CV_AUTOSTEP = $7fffffff;
 Function cvInitMatHeader(  mat: PCvMat; rows, cols,
                              type_: integer; data: pointer = 0;
                              step: integer = CV_AUTOSTEP ): PCvMat; cdecl;
{ Allocates and initalizes CvMat header }
 Function cvCreateMatHeader(rows, cols, type_: integer ): PCvMat; cdecl;
{ Attaches user data to the array header. The step is reffered to
   the pre-last dimension. That is, all the planes of the array
   must be joint (w/o gaps) }
 Procedure cvSetData(arr: PCvArr; data: pointer; step: integer ); cdecl;

 { Allocates array data }
 Procedure cvCreateData( arr : PCvArr ); cdecl;
 { Releases array data  }
 Procedure cvReleaseData(arr : PCvArr ); cdecl;

const
 CV_CN_SHIFT =  3;

 CV_8U  =0;
 CV_8S  =1;
 CV_16U =2;
 CV_16S =3;
 CV_32S =4;
 
 CV_64F =6;

var
//    CV_8UC3 CV_MAKETYPE(CV_8U,3)
    CV_8UC3 : longint;


 { Allocates and initializes CvMat header and allocates data }
 Function cvCreateMat( rows, cols, _type: integer ): PCvMat ; cdecl;

 { Releases CvMat header and deallocates matrix data
   (reference counting is used for data) }
 Procedure cvReleaseMat( mat: P2PCvMat ); cdecl;

 { Selects row span of the input array: arr(start_row:delta_row:end_row,:)
    (end_row is not included into the span). }
 Function cvGetRows( const arr: PCvArr; submat: PCvMat;
                        start_row, end_row: integer;
                        delta_row: integer = 1 ): PCvMat; cdecl;

 Function  cvInvert( const A : PCvArr; B : PCvArr; method : integer ) : double; cdecl;
 Function  cvPseudoInverse( const src : PCvArr; dst : PCvArr ) : double;

// Before OpenCV version 1.0
// Procedure cvMultiplyAcc( const  A,B,C : PCvArr;  D : PCvArr ); cdecl;
 Procedure cvMultiplyAcc( const  A,B,C : PCvArr;  D : PCvArr ); cdecl;
 Procedure cvMul( const  A,B,C : PCvArr;  scale: double=1.0); cdecl;
 Procedure cvMatMul( A,B,D : PCvArr );


// Finds sum of array elements
Function cvSum( arr : PCvArr ): CvScalar; cdecl;

// Calculates number of non-zero pixels
Function cvCountNonZero( arr: PCvArr ): integer; cdecl;

// Subtracts one array from another one
Procedure cvSub( src1, src2, dst: PCvArr; mask: PCvArr = 0 ); cdecl;

// dst(mask) = src1(mask) + src2(mask) */
Procedure cvAdd( src1, src2, dst: PCvArr;
                    mask: PCvArr = 0); cdecl;

// dst(mask) = src(mask) + value */
Procedure  cvAddS( src: PCvArr; value : CvScalar;   dst: PCvArr;
                     mask: PCvArr = 0); cdecl;

const
    CV_CMP_EQ = 0;
    CV_CMP_GT = 1;
    CV_CMP_GE = 2;
    CV_CMP_LT = 3;
    CV_CMP_LE = 4;
    CV_CMP_NE = 5;
// dst(idx) = src1(idx) _cmp_op_ src2(idx) */
Procedure cvCmp( const src1, src2: PCvArr;
                 dst: PCvArr; cmp_op: integer ); cdecl;


// Calculates mean and standard deviation of pixel values */
Procedure  cvAvgSdv( arr: PCvArr;  mean, std_dev: PCvScalar;
                       mask: PCvArr = 0 ); cdecl;

Function cvAvg( arr: PCvarr; mask: PCvarr = nil): cvscalar; cdecl;
//* Finds global minimum, maximum and their positions */
Procedure cvMinMaxLoc( arr: PCvarr; min_val, max_val: Pdouble;
                          var min_loc: Cvpoint;
                          var max_loc: Cvpoint;
                          mask: PCvarr = nil ); cdecl;

const
     CV_DXT_FORWARD    =0;
     CV_DXT_INVERSE    =1;
     CV_DXT_SCALE      =2; //* divide result by size of array */
     CV_DXT_INV_SCALE  = 3;//(CV_DXT_INVERSE + CV_DXT_SCALE)
     CV_DXT_INVERSE_SCALE=CV_DXT_INV_SCALE;
     CV_DXT_ROWS       =4; //* transform each row individually */
     CV_DXT_MUL_CONJ   =8; //* conjugate the second argument of cvMulSpectrums */

{ Discrete Fourier Transform:
    complex->complex,
    real->ccs (forward),
    ccs->real (inverse) }
Procedure  cvDFT( const src, dst: PCvArr; flags: integer;
                    nonzero_rows: integer = 0 ); cdecl;

{ Returns optimal DFT size for a given vector size. }

Function cvGetOptimalDFTSize( size0: integer ): integer;


//* Does cartesian->polar coordinates conversion.
//   Either of output components (magnitude or angle) is optional */
Procedure  cvCartToPolar(  x, y: PCvArr;
                            magnitude: PCvArr; angle: PCvArr = 0;
                            angle_in_degrees: integer = 0); cdecl;

//* Does polar->cartesian coordinates conversion.
//   Either of output components (magnitude or angle) is optional.
//   If magnitude is missing it is assumed to be all 1's */
Procedure cvPolarToCart( magnitude,  angle: PCvArr;
                            x, y: PCvArr;
                            angle_in_degrees: integer = 0); cdecl;


// Calculates the natural logarithm of every array elementҳ absolute value.
Procedure cvLog( const src: PCvArr; dst: PCvArr ); cdecl;


// types of array norm */
const
 CV_C          = 1;
 CV_L1         = 2;
 CV_L2         = 4;
 CV_NORM_MASK  = 7;
 CV_RELATIVE   = 8;
 CV_DIFF       = 16;
 CV_MINMAX     = 32;

 CV_DIFF_C      =(CV_DIFF or CV_C);
 CV_DIFF_L1     =(CV_DIFF or CV_L1);
 CV_DIFF_L2     =(CV_DIFF or CV_L2);
 CV_RELATIVE_C  =(CV_RELATIVE or CV_C);
 CV_RELATIVE_L1 =(CV_RELATIVE or CV_L1);
 CV_RELATIVE_L2 =(CV_RELATIVE or CV_L2);
 Function cvNorm( arr1: PCvarr; arr2: PCvarr=nil; norm_type: Longint=CV_L2; mask: PCvarr=nil ): double;

 const
  CV_32FC1 = 5;
  CV_32FC2 = 13;
  CV_32FC3 = 21;

  CV_32SC1 = 4;
  CV_32SC2 = 12;
  CV_32SC3 = 20;

 Function  cvMat_( rows, cols, type_: Integer; data : Pointer ):TCvMat;
 Function  cvmGet( const mat : PCvMat; i, j : integer): Single;
 Procedure cvmSet( mat : PCvMat; i, j : integer; val: Single);

 Function  cvSize_( width, height : integer ) : TcvSize;

//* simple API for reading/writing data */
 Procedure cvSave( filename: PCvChar; struct_ptr: pointer;
                    name: PCvChar = nil;
                    comment: PCvChar = nil;
                    attributes: pointer = nil); cdecl;
//                    attributes: cvattrlist = nil); cdecl;
 Function cvLoad( filename: PCvChar;
                     memstorage: PCvMemStorage = nil;
                     name: PCvChar = nil;
                     real_name: PCvChar = nil ): pointer; cdecl;


 const
   CV_LOAD_IMAGE_UNCHANGED = -1;
   CV_LOAD_IMAGE_GRAYSCALE = 0;
   CV_LOAD_IMAGE_COLOR = 1;

 function cvLoadImage(const filename: pCvChar; iscolor: Integer = CV_LOAD_IMAGE_UNCHANGED): pIplImage; cdecl;
 Function  cvSaveImage( const filename : PCvChar; const image : Pointer) : integer; cdecl;


{ <malloc> wrapper.
   If there is no enough memory, the function
   (as well as other OpenCV functions that call cvAlloc)
   raises an error. }
 Function  cvAlloc( size: longint ): pointer; cdecl;
{ <free> wrapper.
   Here and further all the memory releasing functions
   (that all call cvFree) take double pointer in order to
   to clear pointer to the data after releasing it.
   Passing pointer to NULL pointer is Ok: nothing happens in this case
}
 Procedure  cvFree( ptr: PPointer); cdecl;

 Procedure cvRelease(struct_ptr: PPointer ); cdecl;


 { Allocates and initializes IplImage header }
 Function cvCreateImageHeader( size : TCvSize; depth, channels : integer ) : PIplImage; cdecl;
 { Releases (i.e. deallocates) IPL image header  : void  cvReleaseImageHeader( IplImage** image );}
 Procedure cvReleaseImageHeader( var image : PIplImage ); cdecl;
 { Releases IPL image header and data }
 Procedure cvReleaseImage(  var image : PIplImage ); cdecl;
 { Creates a copy of IPL image (widthStep may differ). }
 Function  cvCloneImage( const image : PIplImage ) : PIplImage; cdecl;
 { Makes a new matrix from <rect> subrectangle of input array.
   No data is copied }
 Function cvGetSubRect(arr: PCvArr; submat: PCvMat; rect: CvRect ): PCvMat; cdecl;


 { Converts input array from one color space to another. }
 Procedure cvCvtColor( const src : PCvArr; dst : PCvArr; colorCvtCode : integer );  cdecl;

 { Const for cvResize }
type TcvResizeInterpolation = (
 CV_INTER_NN     =  0,
 CV_INTER_LINEAR =  1,
 CV_INTER_CUBIC  =  2,
 CV_INTER_AREA   =  3 );



{ Resizes image (input array is resized to fit the destination array) }
 Procedure cvResize( const src : PCvArr; dst : PCvArr;
                       interpolation: TcvResizeInterpolation = CV_INTER_LINEAR ); cdecl;





 { Creates new memory storage.
   block_size == 0 means that default, somewhat optimal size, is used (currently, it is 64K). }
 Function  cvCreateMemStorage( block_size : integer =0) : PCvMemStorage; cdecl;
 { Releases memory storage. All the children of a parent must be released before
   the parent. A child storage returns all the blocks to parent when it is released  }
 Procedure cvReleaseMemStorage( var storage : PCvMemStorage ); cdecl;

 { Clears memory storage. This is the only way(!!!) (besides cvRestoreMemStoragePos)
   to reuse memory allocated for the storage - cvClearSeq,cvClearSet ...
   do not free any memory.
   A child storage returns all the blocks to the parent when it is cleared }
 Procedure  cvClearMemStorage( storage: PCvMemStorage );


 { Detects corners on a chess-board - "brand" OpenCV calibration pattern }
 { only in OpenCV V1 }
 {$if not Defined(V3) AND Not Defined(V2)}
 Function  cvFindChessBoardCornerGuesses( const arr          : Pointer;
                                                thresh       : Pointer;
                                                storage      : PCvMemStorage;
                                                etalon_size  : TCvSize;
                                                corners      : PCvPoint2D32f;
                                                corner_count : PInteger ) : integer;  cdecl;
{$endif}
 {  Adjust corner position using some sort of gradient search }
 Procedure  cvFindCornerSubPix( const src         : Pointer;
                                      corners     : PCvPoint2D32f;
                                      count       : integer;
                                      win         : TCvSize;
                                      zero_zone   : TCvSize;
                                      criteria    : TCvTermCriteria ); cdecl;


 //cvCreateSeq
{ Creates new empty sequence that will reside in the specified storage }
 Function cvCreateSeq( seq_flags, header_size,
                            elem_size: longint;  storage: PCvMemStorage ): PCvSeq; cdecl;

//cvGetSeqElem
{ Retrives pointer to specified sequence element.
   Negative indices are supported and mean counting from the end
   (e.g -1 means the last sequence element) }
 Function cvGetSeqElem( seq: PCvSeq; index: longint ): PCvChar; cdecl;


 {-----------------------------------------------}
  {Delphi procedure to convert a OCV iplImage to a Delphi bitmap}
 procedure iplImage2Bitmap(img: PIplImage;var bmp:TBitmap);
  {Delphi procedure to convert a Delphi bitmap to a OCV iplImage}
  procedure Bitmap2IplImage(iplImg: PIplImage; bitmap: TBitmap);
  {Delphi procedure to convert a OCV 32 bit iplImage to a 8 bit image}
  procedure IplImage32FTo8Bit(Img32, Img8: PIplImage);

  {functions/procedures not in DLL, written in this unit}
  function cvScalar_(val0:double; val1:double; val2:double; val3:double):CvScalar;
  function cvScalarAll(val0123:double):CvScalar;
  function cvFloor(value: double): longint;
  function cvRound(value:double):longint;
  function cvPoint_( x, y: longint ): CvPoint;
  function cvPointFrom32f_( point: CvPoint2D32f ): CvPoint;
  function  cvPointTo32f_(point: CvPoint ):  CvPoint2D32f;
  function cvTermCriteria_( type_: longint; max_iter: longint; epsilon: double ): CvTermCriteria;
  function CV_RGB(r,g,b : longint) : CvScalar;
  procedure cvEllipseBox(img:PCvArr; box:CvBox2D; color:CvScalar; thickness:longint;
              line_type:longint; shift:longint);
  function  cvRect_( x, y, width, height: longint ): CvRect;
  procedure CV_SWAP(var a, b, t: pointer);
  function cvGetSize(arr: PIplImage):TCvSize;
  function  cvSlice_(start, end_: longint ): CvSlice;
  function cvContourPerimeter( contour: PCvSeq ): double;

  
  procedure cvCalcBackProject(image:P2PIplImage; dst:PCvArr; hist:PCvHistogram);
  procedure cvCalcHist(image:P2PIplImage; hist:PCvHistogram; accumulate:longint; mask:PCvArr);
  function cvQueryHistValue2D(hist:CvHistogram; idx0:longint; idx1:longint):double;


 {-----------------------------------------------}
                           

  { Creates IPL image (header and data)  }
  function cvCreateImage(size:TCvSize; depth:longint; channels:longint):PIplImage;
                        cdecl;


  { Copies source array to destination array  }
  procedure cvCopy(src:PCvArr; dst:PCvArr; mask:PCvArr); cdecl;


  { dst(idx) = ~src(idx) }
  procedure cvNot( src, dst:PCvArr); cdecl;

  { dst(idx) = lower <= src(idx) < upper  }
  procedure cvInRangeS(src:PCvArr; lower:CvScalar; upper:CvScalar; dst:PCvArr);
                cdecl;


  { Creates new histogram  }
  function cvCreateHist(dims:longint; sizes:Plongint; _type:longint; ranges:P2Pfloat;
        uniform:longint): PCvHistogram; cdecl;

  { Releases histogram  }
  procedure cvReleaseHist(hist: P2PCvHistogram); cdecl;

  { Calculates array histogram  }
  procedure cvCalcArrHist(arr:P2PCvArr; hist:PCvHistogram; accumulate:longint; mask:PCvArr);
                cdecl;

  { Finds indices and values of minimum and maximum histogram bins  }
  procedure cvGetMinMaxHistValue(hist:PCvHistogram; min_value:PFloat;
                max_value:PFloat; min_idx:Plongint; max_idx:Plongint);  cdecl;

  { Calculates back project  }
  procedure cvCalcArrBackProject(image:P2PCvArr; dst:PCvArr; hist:PCvHistogram);
                cdecl;

  { equalizes histogram of 8-bit single-channel image }
  procedure  cvEqualizeHist( src, dst:PCvArr ); cdecl;


  { Set array elements to value   }
  procedure cvSet( arr: PCvArr; value: CvScalar; const mask:PCvArr=nil ); cdecl;

  { Clears all the array elements (sets them to 0)  }
  procedure cvSetZero(arr:PCvArr); cdecl;
  procedure cvZero(arr:PCvArr); cdecl;
  
  { Sets image ROI (region of interest) (COI is not changed)  }

  procedure cvSetImageROI(image:PIplImage; rect:CvRect); cdecl;

  { Sets a Channel Of Interest (only a few functions support COI) -
   use cvCopy to extract the selected channel and/or put it back }
  procedure cvSetImageCOI( image: PIplImage; coi: longint ); cdecl;


  { Resets image ROI and COI  }
  procedure cvResetImageROI(image:PIplImage); cdecl;

  { Performs linear transformation on every source array element:
     dst(x,y,c) = scale*src(x,y,c)+shift.
     Arbitrary combination of input and output array depths are allowed
     (number of channels must be the same), thus the function can be used
     for type conversion  }
  procedure cvConvertScale(src:PCvArr; dst:PCvArr; scale:double; shift:double);
                cdecl;


    { Splits a multi-channel array into the set of single-channel arrays or
     extracts particular [color] plane  }

  procedure cvSplit(src:PCvArr; dst0:PCvArr; dst1:PCvArr; dst2:PCvArr; dst3:PCvArr);
                cdecl;
  { Merge until 3 single-channel arrays into a multi-channel array }

  procedure cvMerge(src0:PCvArr; src1:PCvArr; src2:PCvArr; src3:PCvArr; dst:PCvArr);
                cdecl;



  { dst(idx) = src1(idx) & src2(idx)  }
  procedure cvAnd(src1:PCvArr; src2:PCvArr; dst:PCvArr; mask:PCvArr);  cdecl;

  { dst(idx) = src1(idx) | src2(idx)  }
  procedure cvOr(src1:PCvArr; src2:PCvArr; dst:PCvArr; mask:PCvArr);  cdecl;

  { dst(idx) = src1(idx) ^ src2(idx)  }
  procedure cvXor(src1:PCvArr; src2:PCvArr; dst:PCvArr; mask:PCvArr);  cdecl;


  { for 1-channel arrays  }
  function cvGetReal1D(arr:PCvArr; idx0:longint):double; cdecl;
  function cvGetReal2D(arr:PCvArr; idx0:longint; idx1:longint):double; cdecl;
  function cvGetReal3D(arr:PCvArr; idx0:longint; idx1:longint; idx2:longint):double; cdecl;
  function cvGetRealND(arr:PCvArr; idx:Plongint):double; cdecl;


  { for multichannel array, as color images
   value = arr(idx0,idx1,...) }
  function cvGet1D( arr:PCvArr; idx0:longint ): CvScalar; cdecl;
  function cvGet2D( arr:PCvArr; idx0, idx1:longint ): CvScalar; cdecl;
  function cvGet3D( arr:PCvArr; idx0, idx1, idx2:longint ): CvScalar; cdecl;
  function cvGetND( arr:PCvArr; idx: plongint ): CvScalar; cdecl;

  procedure cvSet1D( arr: PCvArr; idx0: integer; value: CvScalar ); cdecl;
  procedure cvSet2D( arr: PCvArr; idx0, idx1: integer; value: CvScalar); cdecl;
  procedure cvSet3D( arr: PCvArr; idx0, idx1, idx2: integer; value: CvScalar); cdecl;
  procedure cvSetND( arr: PCvArr; idx: PInteger;value: CvScalar ); cdecl;



  { dst(idx) = src(idx) ^ value  }
  procedure cvXorS(src:PCvArr; value:CvScalar; dst:PCvArr; mask:PCvArr); cdecl;


{ Draws 4-connected, 8-connected or antialiased line segment connecting two points }
 procedure  cvLine( img: PCvArr; pt1: CvPoint; pt2: CvPoint;
                       color: CvScalar; thickness: longint = 1;
                       line_type: longint = 8; shift: longint = 0); cdecl;

{ Draws one or more polygonal curves }
 procedure  cvPolyLine( img: PCvArr; pts: pointer; npts: PLongint; contours: longint;
                         is_closed: longint;  color: CvScalar; thickness: longint =1;
                         line_type: longint = 8; shift: longint = 0 ); cdecl;


  { Draws a rectangle given two opposite corners of the rectangle (pt1 & pt2),
     if thickness<0 (e.g. thickness == CV_FILLED), the filled box is drawn  }

  procedure cvRectangle(img:PCvArr; pt1:CvPoint; pt2:CvPoint; color:CvScalar;
               thickness:longint; line_type:longint; shift:longint); cdecl;
  { Draws ellipse outline, filled ellipse, elliptic arc or filled elliptic sector,
     depending on <thickness>, <start_angle> and <end_angle> parameters. The resultant figure
     is rotated by <angle>. All the angles are in degrees  }

  procedure cvEllipse(img:PCvArr; center:CvPoint; axes:TCvSize; angle:double;
                start_angle:double; end_angle:double; color:CvScalar;
                thickness:longint; line_type:longint; shift:longint); cdecl;

 { Draws a circle with specified center and radius.
   Thickness works in the same way as with cvRectangle }
 procedure  cvCircle( img: PCvArr; center: CvPoint; radius: longint;
                       color: CvScalar; thickness: longint = 1;
                       line_type: longint = 8; shift: longint = 0); cdecl;


{ basic font types }
type TCvFontFace = (
   CV_FONT_HERSHEY_SIMPLEX       = 0,
   CV_FONT_HERSHEY_PLAIN         = 1,
   CV_FONT_HERSHEY_DUPLEX        = 2,
   CV_FONT_HERSHEY_COMPLEX       = 3,
   CV_FONT_HERSHEY_TRIPLEX       = 4,
   CV_FONT_HERSHEY_COMPLEX_SMALL = 5,
   CV_FONT_HERSHEY_SCRIPT_SIMPLEX= 6,
   CV_FONT_HERSHEY_SCRIPT_COMPLEX= 7 );

const
{ font flags }
   CV_FONT_ITALIC   =              16;

   CV_FONT_VECTOR0  =  CV_FONT_HERSHEY_SIMPLEX;

{ Font structure }
type
 CvFont = record
    font_face: TCvFontFace;  // =CV_FONT_*
    ascii: PInteger;         // font data and metrics
    greek: PInteger;
    cyrillic: PInteger;
    hscale, vscale: float;
    shear: float;            // slope coefficient: 0 - normal, >0 - italic
    thickness: integer;      // letters thickness
    dx: float;               // horizontal interval between letters
    line_type: integer;
  end;
  pCVFont = ^CvFont;


{ Initializes font structure used further in cvPutText  }
 procedure  cvInitFont( font: pCVFont; font_face: TCvFontFace;
                         hscale, vscale: Double;
                         shear: Double = 0;
                         thickness: integer = 1 ;
                         line_type: integer = 8); cdecl;


{ Renders text stroke with specified font and color at specified location.
   CvFont should be initialized with cvInitFont }
 procedure  cvPutText( img: PCvArr; const text: PCvChar; org: CvPoint;
                        const font: pCVFont; color: CvScalar ); cdecl;



  { Implements CAMSHIFT algorithm - determines object position, size and orientation
     from the object histogram back project (extension of meanshift)  }
  function cvCamShift(prob_image:PCvArr; window:CvRect; criteria:CvTermCriteria;
                comp:PCvConnectedComp; box:PCvBox2D):longint; cdecl;

const
 CV_SCHARR = -1;
 CV_MAX_SOBEL_KSIZE= 7;

 { Calculates an image derivative using generalized Sobel
   (aperture_size = 1,3,5,7) or Scharr (aperture_size = -1) operator.
   Scharr can be used only for the first dx or dy derivative }
 Procedure cvSobel( src, dst: PCvArr;
                    xorder, yorder: longint ;
                    aperture_size: longint = 3); cdecl;
 { Calculates the Laplacian of an image }
 Procedure cvLaplace( src: PCvArr;
                      dst: PCvArr;
                      aperture_size: integer=3 ); cdecl;


   { Finds a sparse set of points within the selected region
   that seem to be easy to track }
 procedure  cvGoodFeaturesToTrack( image: PCvArr;
                                   eig_image: PCvArr;
                                   temp_image: PCvArr;
                                   corners: PCvPoint2D32f;
                                   corner_count: PINT;
                                   quality_level: Double;
                                   min_distance: double;
                                   mask: PCvArr = nil;
                                   block_size: longint = 3;
                                   use_harris: longint = 0;
                                   k: double = 0.04 ); cdecl;


{ Harris corner detector:
   Calculates det(M) - k*(trace(M)^2), where M is 2x2 gradient covariation matrix for each pixel }
 procedure  cvCornerHarris( image, harris_responce: PCvArr;
                             block_size: integer; aperture_size: integer = 3;
                             k: double = 0.04 ); cdecl;



 const
 CV_HOUGH_STANDARD=0;
 CV_HOUGH_PROBABILISTIC=1;
 CV_HOUGH_MULTI_SCALE=2;
 CV_HOUGH_GRADIENT=3;

 type
  TCvLine = array [0..1] of CvPoint;
  PTCvLine = ^TCvLine;
  
{Finds lines on binary image using one of several methods.
   line_storage is either memory storage or 1 x <max number of lines> CvMat, its
   number of columns is changed by the function.
   method is one of CV_HOUGH_*;
   rho, theta and threshold are used for each of those methods;
   param1 ~ line length, param2 ~ line gap - for probabilistic,
   param1 ~ srn, param2 ~ stn - for multi-scale }
 Function cvHoughLines2( image: PCvArr; line_storage: pointer; method: longint;
                              rho, theta: Double; threshold: longint;
                              param1: Double = 0; param2: Double=0): PCvSeq; cdecl;


type
  TCvCircle = array[0..2] of single;
  PTCvCircle = ^TCvCircle;
 
// Finds circles in the image */
 Function cvHoughCircles( image: PCvArr; circle_storage: pointer;
                              method: Longint; dp, min_dist: Double;
                              param1: double = 100;
                              param2: double  = 100;
                              min_radius: longint = 0;
                              max_radius: longint = 0): PCvSeq; cdecl;

// Fits a line into set of 2d or 3d points in a robust way (M-estimator technique) */
 Procedure  cvFitLine( points: PCvArr; dist_type: longint; param: double;
                        reps, aeps: double; line: PFloat );  cdecl;


// Fits ellipse into a set of 2d points */
 Function cvFitEllipse2(points: PCvArr ): CvBox2D; cdecl;

// Finds minimum enclosing circle for a set of points */
 Function cvMinEnclosingCircle( points: PCvArr;
                                center: PCvPoint2D32f; radius: PFloat ): integer; cdecl;



const
        CV_GAUSSIAN_5x5 = 7;
{
   Smoothes the input image with gaussian kernel and then down-samples it.
   dst_width = floor(src_width/2)[+1],
   dst_height = floor(src_height/2)[+1]
}
 Procedure  cvPyrDown( ser, dst: PCvArr;
                        filter: longint  = CV_GAUSSIAN_5x5) ; cdecl;

{
   Up-samples image and smoothes the result with gaussian kernel.
   dst_width = src_width*2,
   dst_height = src_height*2
}
 Procedure  cvPyrUp( ser, dst: PCvArr;
                      filter: longint  = CV_GAUSSIAN_5x5) ; cdecl;


{ Filters image using meanshift algorithm }
 Procedure cvPyrMeanShiftFiltering( src, dst: PCvArr;
    sp,  sr: Double;
    max_level: integer;
    termcrit: CvTermCriteria
    // CV_DEFAULT(cvTermCriteria(CV_TERMCRIT_ITER+CV_TERMCRIT_EPS,5,1))
    ); cdecl;



// cvCanny
var
    CV_CANNY_L2_GRADIENT: longint; { =(1 << 31)

{ Runs canny edge detector }
 Procedure  cvCanny( image, edges: PCvArr; threshold1: double;
                      threshold2: double; aperture_size: longint  = 3); cdecl;


type TStructElemShape = (
  CV_SHAPE_RECT   =  0,
  CV_SHAPE_CROSS  =  1,
  CV_SHAPE_ELLIPSE=  2,
  CV_SHAPE_CUSTOM =  100 );

{ creates structuring element used for morphological operations }
 Function  cvCreateStructuringElementEx(
            cols, rows, anchor_x, anchor_y: integer;
            shape: TStructElemShape; values: PInteger = nil ): PIplConvKernel; cdecl;

{ releases structuring element }
 Procedure  cvReleaseStructuringElement(element: P2PIplConvKernel); cdecl;



 { Erodes image by using arbitrary structuring element }
 Procedure  cvErode( src, dst: PCvArr;
                       element: PIplConvKernel  = nil;
                       iterations: longint  = 1) ; cdecl;

//cvDilate
{ dilates input image (applies maximum filter) one or more times.
   If element pointer is NULL, 3x3 rectangular element is used }
 Procedure  cvDilate( src, dst: PCvArr;
                       element: PIplConvKernel  = nil;
                       iterations: longint  = 1) ; cdecl;

type TCvMorphOperation = (
 CV_MOP_OPEN      =  2,
 CV_MOP_CLOSE     =  3,
 CV_MOP_GRADIENT  =  4,
 CV_MOP_TOPHAT    =  5,
 CV_MOP_BLACKHAT  =  6);

{ Performs complex morphological transformation }
 Procedure  cvMorphologyEx( src, dst, temp: PCvArr;
                             element: PIplConvKernel;
                             operation: TCvMorphOperation; iterations: integer = 1);  cdecl;


 {Copies source 2D array inside of the larger destination array and
   makes a border of the specified type (IPL_BORDER_*) around the copied area. }
 Procedure cvCopyMakeBorder( src, dst: PCvArr;  offset: CvPoint;
                              bordertype: integer; value: CvScalar ); cdecl;




// smoothtype constants
type TCvSmoothType = (
    CV_BLUR_NO_SCALE =0,
    CV_BLUR          =1,
    CV_GAUSSIAN      =2,
    CV_MEDIAN        =3,
    CV_BILATERAL     =4);



//cvSmooth
{ Smooths the image in one of several ways }

 Procedure cvSmooth( src, dst: PCvArr;
               smoothtype: TCvSmoothType;
               param1: longint=3; param2: longint=0;
               param3: double=0; param4: double=0 ); cdecl;

{ Convolves an image with the kernel. }

 Procedure cvFilter2D(const src: PCvArr; dst: PCvArr;
                        const kernel: PCvMat;
                        anchor: CvPoint); cdecl;


// cvThreshold
{ Types of thresholding }
const
    CV_THRESH_BINARY     =0; { value = value > threshold ? max_value : 0       }
    CV_THRESH_BINARY_INV =1; { value = value > threshold ? 0 : max_value       }
    CV_THRESH_TRUNC      =2; { value = value > threshold ? threshold : value   }
    CV_THRESH_TOZERO     =3; { value = value > threshold ? value : 0           }
    CV_THRESH_TOZERO_INV =4; { value = value > threshold ? 0 : value           }
    CV_THRESH_MASK       =7;

    CV_THRESH_OTSU       =8; { use Otsu algorithm to choose the optimal threshold value;
                                    combine the flag with one of the above CV_THRESH_* values }

{ Applies fixed-level threshold to grayscale image.
   This is a basic operation applied before retrieving contours }
 Procedure  cvThreshold( src, dst: PCvArr ;
                          threshold, max_value: double;
                          threshold_type: longint ); cdecl;

const
    CV_ADAPTIVE_THRESH_MEAN_C     = 0;
    CV_ADAPTIVE_THRESH_GAUSSIAN_C = 1;

{ Applies adaptive threshold to grayscale image.
   The two parameters for methods CV_ADAPTIVE_THRESH_MEAN_C and
   CV_ADAPTIVE_THRESH_GAUSSIAN_C are:
   neighborhood size (3, 5, 7 etc.),
   and a constant subtracted from mean (...,-3,-2,-1,0,1,2,3,...) }
Procedure  cvAdaptiveThreshold( src,dst: PCvArr; max_value: double;
                                  adaptive_method: integer =CV_ADAPTIVE_THRESH_MEAN_C;
                                  threshold_type: integer = CV_THRESH_BINARY;
                                  block_size: integer = 3;
                                  param1: double = 5.0);  cdecl;

const
 CV_FLOODFILL_FIXED_RANGE = (1 shl 16);
 CV_FLOODFILL_MASK_ONLY   = (1 shl 17);
{ Fills a connected component with the given color. }
Procedure cvFloodFill(
        image: PCvArr;
        seed_point: CvPoint;
        new_val: CvScalar;
        lo_diff: CvScalar;
        up_diff: CvScalar;
        comp: PCvConnectedComp=nil;
        flags: integer=4;
        mask: PCvArr=nil ); cdecl;

{ contour retrieval mode }
const
 CV_RETR_EXTERNAL=0;
 CV_RETR_LIST    =1;
 CV_RETR_CCOMP   =2;
 CV_RETR_TREE    =3;

{ contour approximation method }
 CV_CHAIN_CODE              =0;
 CV_CHAIN_APPROX_NONE       =1;
 CV_CHAIN_APPROX_SIMPLE     =2;
 CV_CHAIN_APPROX_TC89_L1    =3;
 CV_CHAIN_APPROX_TC89_KCOS  =4;
 CV_LINK_RUNS               =5;





// cvFindContours
{ Retrieves outer and optionally inner boundaries of white (non-zero) connected
   components in the black (zero) background }
   // cvPoint(0,0)
 Function  cvFindContours( image: PCvArr;  storage: PCvMemStorage;
                            first_contour: pointer; { CvSeq**}
                            header_size: longint; {  = sizeof(CvContour)}
                            mode: longint; // = CV_RETR_LIST;
                            method: longint; // = CV_CHAIN_APPROX_SIMPLE;
                            offset: CvPoint // = CvPoint_(0,0)
                            ): longint; cdecl;

//cvApproxPoly
const
    CV_POLY_APPROX_DP = 0;

{ Approximates a single polygonal curve (contour) or
   a tree of polygonal curves (contours) }
 Function cvApproxPoly(  src_seq: pointer;
                             header_size: longint; storage: PCvMemStorage;
                             method: longint; parameter: double;
                             parameter2: longint  = 0): PCvSeq; cdecl;

//cvContourArea
{ Calculates area of a contour or contour segment }
 Function cvContourArea( contour: PCvArr ;
                         slice: CvSlice // = CV_WHOLE_SEQ
                         ): double; cdecl;

{Calculates perimeter of a contour or length of a part of contour }
 Function  cvArcLength( curve: pointer;
                            slice: CvSlice; // = CV_WHOLE_SEQ;
                            is_closed: longint = -1): double; cdecl;


const
        CV_CLOCKWISE        = 1;
        CV_COUNTER_CLOCKWISE= 2;

{ Calculates exact convex hull of 2d point set }
function cvConvexHull2( const input: PCvArr;
                             hull_storage: pointer=0;
                             orientation: integer = CV_CLOCKWISE;
                             return_points: integer = 0): pcvseq; cdecl;

//cvCheckContourConvexity
{ Checks whether the contour is convex or not (returns 1 if convex, 0 if not) }
 Function  cvCheckContourConvexity(contour: PCvArr ): longint; cdecl;

{ Draws contour outlines or filled interiors on the image }
 Procedure  cvDrawContours( img: PCvArr; contour: PCvSeq;
                            external_color, hole_color: CvScalar;
                            max_level: longint; thickness: longint; // = 1;
                            line_type: longint; //  = 8;
                            offset: CvPoint); cdecl; //  CV_DEFAULT(cvPoint(0,0));
{ The function implements the K-means algorithm for clustering an array of sample
   vectors in a specified number of classes }
 Procedure  cvKMeans2( const samples: PCvArr; cluster_count: integer;
                        labels: PCvArr; termcrit: CvTermCriteria ); cdecl;

{ Calculates contour boundning rectangle (update=1) or
   just retrieves pre-calculated rectangle (update=0) }
 Function  cvBoundingRect( points: PCvArr; update: longint = 0 ): CvRect;


{************************************ optical flow ***************************************/}

{ Calculates optical flow for 2 images using classical Lucas & Kanade algorithm }
 procedure  cvCalcOpticalFlowLK( prev: PCvarr; curr: PCvarr;
                                  win_size: TCvSize ; velx, vely: PCvarr ); cdecl;

{ Calculates optical flow for 2 images using block matching algorithm }
procedure  cvCalcOpticalFlowBM( prev: PCvarr; curr: PCvarr;
                                  block_size, shift_size: TCvSize;
                                  max_range: TCvSize; use_previous: longint;
                                  velx, vely: PCvarr );  cdecl;

{ Calculates Optical flow for 2 images using Horn & Schunck algorithm }
procedure  cvCalcOpticalFlowHS( prev: PCvarr; curr: PCvarr;
                                  use_previous: longint; velx, vely: PCvarr;
                                  lambda: double; criteria: CvTermCriteria  ); cdecl;


 const CV_LKFLOW_PYR_A_READY =      1;
       CV_LKFLOW_PYR_B_READY =      2;
       CV_LKFLOW_INITIAL_GUESSES =  4;

{ It is Lucas & Kanade method, modified to use pyramids.
   Also it does several iterations to get optical flow for
   every point at every pyramid level.
   Calculates optical flow between two images for certain set of points (i.e.
   it is a "sparse" optical flow, which is opposite to the previous 3 methods) }
 procedure  cvCalcOpticalFlowPyrLK( prev: PCvArr;
                                    curr: PCvArr;
                                     prev_pyr: PCvArr;
                                     curr_pyr: PCvArr;
                                     prev_features: PCvPoint2D32f;
                                     curr_features: PCvPoint2D32f;
                                     count: longint;
                                     win_size: TCvSize;
                                     level: longint;
                                     status: PCvChar;
                                     track_error: PSingle;
                                     criteria: CvTermCriteria;
                                     flags: longint );  cdecl;

  {***************************************************************************************\
  *                         Moments                                                      *
  \*************************************************************************************** }
 { spatial and central moments }
type
  CvMoments = record
    m00, m10, m01, m20, m11, m02, m30, m21, m12, m03: double; // spatial moments
    mu20, mu11, mu02, mu30, mu21, mu12, mu03: double; // central moments
    inv_sqrt_m00: double; // m00 != 0 ? 1/sqrt(m00) : 0
  end;
  PCvMoments = ^CvMoments;


{ Hu invariants }
  CvHuMoments = record
    hu1, hu2, hu3, hu4, hu5, hu6, hu7: double; // Hu invariants
  end;
  PCvHuMoments = ^CvHuMoments;

{ Calculates all spatial and central moments up to the 3rd order }
procedure cvCalcMoments( arr: PCvArr; moments: PCvMoments; binary: longint = 0); cdecl;

{ Retrieve particular spatial, central or normalized central moments }
function  cvGetSpatialMoment( moments: PCvMoments;x_order, y_order: longint ): double; cdecl;
function  cvGetCentralMoment( moments: PCvMoments;x_order, y_order: longint ): double; cdecl;
function  cvGetNormalizedCentralMoment( moments: PCvMoments;x_order,
                                                y_order: longint): double; cdecl;

{ Calculates 7 Hu's invariants from precalculated spatial and central moments }
procedure cvGetHuMoments( moments: PCvMoments; hu_moments: PCvHuMoments );  cdecl;

const
CV_CONTOURS_MATCH_I1 = 1;
CV_CONTOURS_MATCH_I2 = 2;
CV_CONTOURS_MATCH_I3 = 3;

{ Compares two contours by matching their moments }
Function cvMatchShapes( const object1, object2: pointer;
                              method: integer; parameter: double = 0): double; cdecl;

{ Methods for comparing two array }
type TCVMatchTemplateMethod =  (
 CV_TM_SQDIFF       = 0,
 CV_TM_SQDIFF_NORMED= 1,
 CV_TM_CCORR        = 2,
 CV_TM_CCORR_NORMED = 3,
 CV_TM_CCOEFF       = 4,
 CV_TM_CCOEFF_NORMED= 5);

{ Measures similarity between template and overlapped windows in the source image
   and fills the resultant image with the measurements }
procedure  cvMatchTemplate( image, templ,result: PIplImage; method: TCVMatchTemplateMethod ); cdecl;

(* ***************************************************************************************\
  *                                  Basic GUI functions                                   *
  *************************************************************************************** *)

(* For font *)
const
  CV_FONT_LIGHT = 25; // QFont::Light;
  CV_FONT_NORMAL = 50; // QFont::Normal;
  CV_FONT_DEMIBOLD = 63; // QFont::DemiBold;
  CV_FONT_BOLD = 75; // QFont::Bold;
  CV_FONT_BLACK = 87; // QFont::Black;
  CV_STYLE_NORMAL = 0; // QFont::StyleNormal;
  CV_STYLE_ITALIC = 1; // QFont::StyleItalic;
  CV_STYLE_OBLIQUE = 2; // QFont::StyleOblique;

  // for color cvScalar(blue_component, green_component, red\_component[, alpha_component])
  // and alpha= 0 <-> 0xFF (not transparent <-> transparent)
  (*
    CVAPI(CvFont) cvFontQt(const char* nameFont, int pointSize CV_DEFAULT(-1), CvScalar color CV_DEFAULT(cvScalarAll(0)), int weight CV_DEFAULT(CV_FONT_NORMAL),  int style CV_DEFAULT(CV_STYLE_NORMAL), int spacing CV_DEFAULT(0));
  *)


//function cvFontQt(const nameFont: pCvChar; pointSize: Integer { = -1 }; color: CvScalar { = CV_DEFAULT(cvScalarAll(0)) };
//  weight: Integer { = CV_DEFAULT(CV_FONT_NORMAL) }; style: Integer { = CV_DEFAULT(CV_STYLE_NORMAL) }; spacing: Integer { = CV_DEFAULT(0) } )
//  : CvFont; cdecl;
//
//(*
//  CVAPI(void) cvAddText(const CvArr* img, const char* text, CvPoint org, CvFont *arg2);
//*)
//
//procedure cvAddText(const img: pCvArr; const text: pCvChar; org: CvPoint; arg2: pCvFont); cdecl;
//
//(*
//  CVAPI(void) cvDisplayOverlay(const char* name, const char* text, int delayms CV_DEFAULT(0));
//*)
//
//procedure cvDisplayOverlay(const name: pCvChar; const text: pCvChar; delayms: Integer = 0); cdecl;
//
//(*
//  CVAPI(void) cvDisplayStatusBar(const char* name, const char* text, int delayms CV_DEFAULT(0));
//*)
//
//procedure cvDisplayStatusBar(const name: pCvChar; const text: pCvChar; delayms: Integer = 0); cdecl;
//
//(*
//  CVAPI(void) cvSaveWindowParameters(const char* name);
//*)
//
//procedure cvSaveWindowParameters(const name: pCvChar); cdecl;
//
//(*
//  CVAPI(void) cvLoadWindowParameters(const char* name);
//*)
//
//procedure cvLoadWindowParameters(const name: pCvChar); cdecl;
//
//
//Type
//  (* int (*pt2Func)(int argc, char *argv[]) *)
//  TArgvArray = array [0 .. 0] of pCvChar;
//  pArgvArray = ^TArgvArray;
//  Tpt2Func = function(argc: Integer; argv: pArgvArray): Integer; cdecl;
//  (*
//    CVAPI(int) cvStartLoop(int (*pt2Func)(int argc, char *argv[]), int argc, char* argv[]);
//  *)
//
//function cvStartLoop(pt2Func: Tpt2Func): Integer; cdecl;
//
//(*
//  CVAPI(void) cvStopLoop( void );
//*)
//
//procedure cvStopLoop; cdecl;
//
//
//Type
//  (* typedef  void (CV_CDECL *CvButtonCallback)(int state, void* userdata); *)
//  TCvButtonCallback = procedure(state: Integer; userdata: Pointer); cdecl;
//
//const
//  (* enum  {CV_PUSH_BUTTON = 0, CV_CHECKBOX = 1, CV_RADIOBOX = 2}; *)
//  CV_PUSH_BUTTON = 0;
//  CV_CHECKBOX = 1;
//  CV_RADIOBOX = 2;
//  (*
//    CVAPI(int) cvCreateButton( const char* button_name CV_DEFAULT(NULL),CvButtonCallback on_change CV_DEFAULT(NULL), void* userdata CV_DEFAULT(NULL) , int button_type CV_DEFAULT(CV_PUSH_BUTTON), int initial_button_state CV_DEFAULT(0));
//  *)
//
//function cvCreateButton(const button_name: pCvChar = nil; on_change: TCvButtonCallback = nil; userdata: Pointer = nil;
//  button_type: Integer = CV_PUSH_BUTTON; initial_button_state: Integer = 0): Integer; cdecl;
//
//(*
//  this function is used to set some external parameters in case of X Window */
//  CVAPI(int) cvInitSystem( int argc, char** argv );
//*)


function cvInitSystem(argc: Integer; argv: ppCVChar): Integer; cdecl;

// CVAPI(int) cvStartWindowThread( void );

function cvStartWindowThread: Integer; cdecl;


// ---------  YV ---------
// These 3 flags are used by cvSet/GetWindowProperty;
const
  CV_WND_PROP_FULLSCREEN = 0; // to change/get window's fullscreen property
  CV_WND_PROP_AUTOSIZE = 1; // to change/get window's autosize property
  CV_WND_PROP_ASPECTRATIO = 2; // to change/get window's aspectratio property
  CV_WND_PROP_OPENGL = 3; // to change/get window's opengl support
  // These 2 flags are used by cvNamedWindow and cvSet/GetWindowProperty;
  CV_WINDOW_NORMAL = $00000000;
  // the user can resize the window (no raint)  / also use to switch a fullscreen window to a normal size
  CV_WINDOW_AUTOSIZE = $00000001;
  // the user cannot resize the window; the size is rainted by the image displayed
  CV_WINDOW_OPENGL = $00001000; // window with opengl support
  // Those flags are only for Qt;
  CV_GUI_EXPANDED = $00000000; // status bar and tool bar
  CV_GUI_NORMAL = $00000010; // old fashious way
  // These 3 flags are used by cvNamedWindow and cvSet/GetWindowProperty;
  CV_WINDOW_FULLSCREEN = 1; // change the window to fullscreen
  CV_WINDOW_FREERATIO = $00000100; // the image expends as much as it can (no ratio raint)
  CV_WINDOW_KEEPRATIO = $00000000; // the ration image is respected.;

  (* create window *)


function cvNamedWindow(const name: pCvChar; flags: Integer = CV_WINDOW_AUTOSIZE): Integer; cdecl;

// Set and Get Property of the window

procedure cvSetWindowProperty(name: pCvChar; prop_id: Integer; prop_value: Double); cdecl;

function cvGetWindowProperty(name: pCvChar; prop_id: Integer): Double; cdecl;


(*
  display image within window (highgui windows remember their content)
  CVAPI(void) cvShowImage( const char* name, const CvArr* image );
*)


procedure cvShowImage(const name: pCvChar; const image: pCvArr); cdecl;

// procedure cvShowImage(const name: pCVChar; const image: pIplImage); cdecl; overload;
// procedure cvShowImage(const name: pCVChar; const image: pCvMat); cdecl; overload;

(* resize/move window *)

procedure cvResizeWindow(name: pCvChar; width: Integer; height: Integer); cdecl;

// CVAPI(void) cvMoveWindow( const char* name, int x, int y );

procedure cvMoveWindow(const name: pCvChar; x: Integer; y: Integer); cdecl;


(* destroy window and all the trackers associated with it *)


procedure cvDestroyWindow(const name: pCvChar); cdecl;


procedure cvDestroyAllWindows; cdecl;

(*
  get native window handle (HWND in case of Win32 and Widget in case of X Window)
  CVAPI(void* ) cvGetWindowHandle( const char* name );
*)

function cvGetWindowHandle(const name: pCvChar): Pointer; cdecl;

(*
  get name of highgui window given its native handle
  CVAPI(const char* ) cvGetWindowName( void* window_handle );
*)

function cvGetWindowName(window_handle: Pointer): pCvChar; cdecl;


type
  TCvTrackbarCallback = procedure(pos: Integer); cdecl;

  (* create trackbar and display it on top of given window, set callback *)
type
  TcvCreateTrackbar = function(const trackbar_name: pCvChar; const window_name: pCvChar; value: PInteger; count: Integer;
    on_change: TCvTrackbarCallback): Integer; cdecl;

function cvCreateTrackbar(const trackbar_name: pCvChar; const window_name: pCvChar; value: PInteger; count: Integer; on_change: TCvTrackbarCallback)
  : Integer; cdecl;


type
  TCvTrackbarCallback2 = procedure(pos: Integer; userdata: Pointer); cdecl;

  // CVAPI(int) cvCreateTrackbar2( const char* trackbar_name, const char* window_name,
  // int* value, int count, CvTrackbarCallback2 on_change,
  // void* userdata CV_DEFAULT(0));

function cvCreateTrackbar2(const trackbar_name: pCvChar; const window_name: pCvChar; value: PInteger; count: Integer; on_change: TCvTrackbarCallback2;
  userdata: Pointer = nil): Integer; cdecl;

// * retrieve or set trackbar position */
// CVAPI(int) cvGetTrackbarPos( const char* trackbar_name, const char* window_name );

function cvGetTrackbarPos(const trackbar_name: pCvChar; const window_name: pCvChar): Integer; cdecl;

// CVAPI(void) cvSetTrackbarPos( const char* trackbar_name, const char* window_name, int pos );
procedure cvSetTrackbarPos(const trackbar_name: pCvChar; const window_name: pCvChar; pos: Integer); cdecl;


const
  CV_EVENT_MOUSEMOVE = 0;
  CV_EVENT_LBUTTONDOWN = 1;
  CV_EVENT_RBUTTONDOWN = 2;
  CV_EVENT_MBUTTONDOWN = 3;
  CV_EVENT_LBUTTONUP = 4;
  CV_EVENT_RBUTTONUP = 5;
  CV_EVENT_MBUTTONUP = 6;
  CV_EVENT_LBUTTONDBLCLK = 7;
  CV_EVENT_RBUTTONDBLCLK = 8;
  CV_EVENT_MBUTTONDBLCLK = 9;
  CV_EVENT_FLAG_LBUTTON = 1;
  CV_EVENT_FLAG_RBUTTON = 2;
  CV_EVENT_FLAG_MBUTTON = 4;
  CV_EVENT_FLAG_CTRLKEY = 8;
  CV_EVENT_FLAG_SHIFTKEY = 16;
  CV_EVENT_FLAG_ALTKEY = 32;

  // type
  // CvMouseCallback = procedure(event: Integer; x: Integer; y: Integer; flags: Integer; param: Pointer); cdecl;

  (* assign callback for mouse events *)
  // CVAPI(procedure)cvSetMouseCallback(var 8 bit = 0; color or not * )
  {
    CVAPI(void) cvSetMouseCallback( const char* window_name, CvMouseCallback on_mouse,
    void* param CV_DEFAULT(NULL));
  }

Type
  // typedef void (CV_CDECL *CvMouseCallback )(int event, int x, int y, int flags, void* param);
  TCvMouseCallback = procedure(event: Integer; x, y, flags: Integer; param: Pointer); cdecl;


procedure cvSetMouseCallback(const window_name: pCvChar; on_mouse: TCvMouseCallback; param: Pointer = nil); cdecl;


const
  //CV_LOAD_IMAGE_UNCHANGED = -1;     // definovány výše
  //(* 8bit= 1; gray *)
  //CV_LOAD_IMAGE_GRAYSCALE = 0;
  //(* ?= 2; color *)
  //CV_LOAD_IMAGE_COLOR = 1;
  (* any depth= 3; ? *)
  CV_LOAD_IMAGE_ANYDEPTH = 2;
  (* ?= 4; any color *)
  CV_LOAD_IMAGE_ANYCOLOR = 4;

  (* load image from file  iscolor can be a combination of above flags where
    CV_LOAD_IMAGE_UNCHANGED  overrides the other flags
    using CV_LOAD_IMAGE_ANYCOLOR alone is equivalent to CV_LOAD_IMAGE_UNCHANGED
    unless CV_LOAD_IMAGE_ANYDEPTH is specified images are converted to 8bit
    CVAPI(IplImage* ) cvLoadImage(const char* filename,int iscolor CV_DEFAULT(CV_LOAD_IMAGE_COLOR));
  *)

(*
  CVAPI(CvMat* ) cvLoadImageM( const char* filename, int iscolor CV_DEFAULT(CV_LOAD_IMAGE_COLOR));
*)

function cvLoadImageM(const filename: pCvChar; iscolor: integer=CV_LOAD_IMAGE_COLOR): pCvMat; cdecl;


(*
  decode image stored in the buffer
  CVAPI(IplImage* ) cvDecodeImage( const CvMat* buf, int iscolor CV_DEFAULT(CV_LOAD_IMAGE_COLOR));
*)
function cvDecodeImage(const buf: pCvMat; iscolor: integer=CV_LOAD_IMAGE_COLOR): pIplImage; cdecl;

(*
  CVAPI(CvMat* ) cvDecodeImageM( const CvMat* buf, int iscolor CV_DEFAULT(CV_LOAD_IMAGE_COLOR));
*)

function cvDecodeImageM(const buf: pCvMat; iscolor: integer=CV_LOAD_IMAGE_COLOR): pCvMat; cdecl;

(*
  encode image and store the result as a byte vector (single-row 8uC1 matrix)
  CVAPI(CvMat* cvEncodeImage( const char* ext, const CvArr* image,
  const int* params CV_DEFAULT(0) );
*)

function cvEncodeImage(const ext: pCvChar; const image: pCvArr; const params: PInteger = nil): pCvMat; cdecl;


const
  (* enum
    {
    CV_CVTIMG_FLIP      =1,
    CV_CVTIMG_SWAP_RB   =2
    }; *)
  CV_CVTIMG_FLIP = 1;
  CV_CVTIMG_SWAP_RB = 2;

  (*
    utility function: convert one image to another with optional vertical flip
  *)
  (*
    CVAPI(void) cvConvertImage( const CvArr* src, CvArr* dst, int flags CV_DEFAULT(0));
  *)


procedure cvConvertImage(const src: pCvArr; dst: pCvArr; flags: Integer = 0); cdecl; // overload;


// {
// /* utility function: convert one image to another with optional vertical flip */
// CVAPI(void) cvConvertImage( const CvArr* src, CvArr* dst, int flags CV_DEFAULT(0));
// }
// {$IFDEF SAFELOADLIB}
// {$ELSE}
// procedure cvConvertImage(const src: pIplImage; dst: pIplImage; flags: Integer = 0); cdecl; overload;
// {$ENDIF}
(* wait for key event infinitely (delay<=0) or for "delay" milliseconds *)

function cvWaitKey(delay: Integer = 0): Integer; cdecl;

// OpenGL support

(*
  typedef void (CV_CDECL *CvOpenGlDrawCallback)(void* userdata);
  CVAPI(void) cvSetOpenGlDrawCallback(const char* window_name, CvOpenGlDrawCallback callback, void* userdata CV_DEFAULT(NULL));
*)
Type
  TCvOpenGlDrawCallback = procedure(userdata: Pointer); cdecl;
procedure cvSetOpenGlDrawCallback(const window_name: pCvChar; callback: TCvOpenGlDrawCallback; userdata: Pointer = nil);

// CVAPI( procedure)cvSetOpenGlContext(window_name: PCVChar);

procedure cvSetOpenGlContext(window_name: pCvChar); cdecl;

// CVAPI(procedure)cvUpdateWindow(window_name: PCVChar);

procedure cvUpdateWindow(window_name: pCvChar); cdecl;



  {***************************************************************************************\
  *                         Working with Video Files and Cameras                           *
  \*************************************************************************************** }

  { Delphi version of C macro }
  function CV_FOURCC(ch1, ch2, ch3, ch4: CvChar): integer;


  { "black box" capture structure  }
  type
    CvCapture = record
    end;
    PCvCapture = ^CvCapture;
    P2PCvCapture = ^PCvCapture;

  { start capturing frames from video file  }
  function cvCaptureFromFile(filename:PCvChar): PCvCapture; cdecl;
  function cvCreateFileCapture(filename:PCvChar): PCvCapture; cdecl;



  const
     CV_CAP_ANY = 0;
     CV_CAP_MIL = 100;
     CV_CAP_VFW = 200;
     CV_CAP_DSHOW  =700;   // DirectShow (via videoInput)
     CV_CAP_V4L = 200;
     CV_CAP_V4L2 = 200;
     CV_CAP_FIREWARE = 300;
     CV_CAP_IEEE1394 = 300;
     CV_CAP_DC1394 = 300;
     CV_CAP_CMU1394 = 300;

  { start capturing frames from camera: index = camera_index + domain_offset (CV_CAP_*)}
  function cvCaptureFromCAM(index:longint):PCvCapture; cdecl;
  function cvCreateCameraCapture(index:longint):PCvCapture; cdecl;

  { grab a frame, return 1 on success, 0 on fail.
    this function is thought to be fast                }
  function cvGrabFrame(capture:PCvCapture):longint; cdecl;

  { get the frame grabbed with cvGrabFrame(..)
   This function may apply some frame processing like
   frame decompression, flipping etc.
  !!!DO NOT RELEASE or MODIFY the retrieved frame!!!  }

  function cvRetrieveFrame(capture:PCvCapture): PIplImage; cdecl;

  { Just a combination of cvGrabFrame and cvRetrieveFrame
     !!!DO NOT RELEASE or MODIFY the retrieved frame!!!       }
  function cvQueryFrame(capture:PCvCapture):PIplImage;  cdecl;

  { stop capturing/reading and free resources  }
  procedure cvReleaseCapture(capture:P2PCvCapture);  cdecl;


  { "black box" video file writer structure }
  type
        PCvVideoWriter = pointer;
        P2PCvVideoWriter = pointer;

  { initialize video file writer }
  function cvCreateVideoWriter( const filename: PCvChar; fourcc: integer;
                                           fps: double; frame_size: Tcvsize;
                                           is_color: integer = 1): pcvvideowriter; cdecl;

  { write frame to video file }
  function cvWriteFrame( writer: PCvVideoWriter; const image: PIplImage ): integer; cdecl;

  { close video file writer }
  procedure cvReleaseVideoWriter( writer: P2PCvVideoWriter  );  cdecl;


const
 CV_CAP_PROP_POS_MSEC      =0;
 CV_CAP_PROP_POS_FRAMES    =1;
 CV_CAP_PROP_POS_AVI_RATIO =2;
 CV_CAP_PROP_FRAME_WIDTH   =3;
 CV_CAP_PROP_FRAME_HEIGHT  =4;
 CV_CAP_PROP_FPS           =5;
 CV_CAP_PROP_FOURCC        =6;
 CV_CAP_PROP_FRAME_COUNT   =7;
 CV_CAP_PROP_FORMAT        =8;
 CV_CAP_PROP_MODE          =9;
 CV_CAP_PROP_BRIGHTNESS   =10;
 CV_CAP_PROP_CONTRAST     =11;
 CV_CAP_PROP_SATURATION   =12;
 CV_CAP_PROP_HUE          =13;
 CV_CAP_PROP_GAIN         =14;
 CV_CAP_PROP_CONVERT_RGB  =15;


{ retrieve or set capture properties }
function cvGetCaptureProperty( capture: PCvCapture; property_id: longint ): double; cdecl;
function cvSetCaptureProperty( capture: PCvCapture; property_id: longint; value: double ): longint; cdecl;



{----------------------------------------------------}
{ CVCam auxiliary library, only in OpenCV V1 }
{$ifndef V3}
{$ifndef V2}
const
 CVCAM_PROP_ENABLE: string = 'enable';
 CVCAM_PROP_RENDER: string = 'render';
 CVCAM_PROP_WINDOW: string = 'window';
 CVCAM_PROP_CALLBACK: string = 'callback';
 CVCAM_DESCRIPTION: string = 'description';
 CVCAM_VIDEOFORMAT: string = 'video_pp';
 CVCAM_CAMERAPROPS: string = 'camera_pp';
 CVCAM_RNDWIDTH: string = 'rendering_width';
 CVCAM_RNDHEIGHT: string = 'rendering_height';
 CVCAM_SRCWIDTH: string = 'source_width';
 CVCAM_SRCHEIGHT: string = 'source_height';
 CVCAM_STEREO_CALLBACK: string = 'stereo_callback';
 CVCAM_STEREO3_CALLBACK: string = 'stereo3_callback';
 CVCAM_STEREO4_CALLBACK: string = 'stereo4_callback';
 CVCAM_PROP_SETFORMAT: string = 'set_video_format';
 CVCAM_PROP_RAW: string = 'raw_image';
 CVCAM_PROP_TIME_FORMAT: string = 'time_format';
 CVCAM_PROP_DURATION: string = 'duration';
 CVCAM_PROP_POSITION: string = 'current_position';


 CVCAMTRUE = 1;
 CVCAMFALSE= 0;

type
 VidFormat = record
    width: longint;
    height: longint;
    framerate: double;
 end;

 CameraDescription = record
    DeviceDescription: array[0..99] of CvChar;
    device: array[0..99] of CvChar;
    channel: longint;
    ChannelDescription: array[0..99] of CvChar;
    maxwidth: longint;
    maxheight: longint;
    minwidth: longint;
    minheight: longint;
 end;


 { Returns the actual number of currently available cameras }
 function cvcamGetCamerasCount(): longint; cdecl;
 function cvcamSelectCamera(var outc: PLongint): longint; cdecl;
 function cvcamInit(): longint; cdecl;
 function cvcamStart(): longint; cdecl;
 function cvcamPause(): longint; cdecl;
 function cvcamResume(): longint; cdecl;
 function cvcamStop(): longint; cdecl;
 function cvcamExit(): longint; cdecl;
 { get/set the property of the camera. returns 0 if the property is not supported }
 function cvcamGetProperty(camera: longint;  prop: string; value: pointer): longint; cdecl;
 function cvcamSetProperty(camera: longint; prop: string; value: pointer): longint; cdecl;
{$endif}
{$endif}

  {***************************************************************************************\
  *                         Perspective and 3D functions                                  *
  \*************************************************************************************** }
const
     CV_WARP_FILL_OUTLIERS = 8;
     CV_WARP_INVERSE_MAP   = 16;

  (* read a raster line to a buffer, the pixels are in the original image format
   i.e. 3 bytes per pixels in BGR, 1 byte per pixel in gray, ecc.  *)
 Function cvSampleLine(
          const image: PCvArr;
          pt1: CvPoint;
          pt2: CvPoint;
          buffer: Pointer;
          connectivity: integer=8 ): integer; cdecl;

  (* projects object points to the view plane using
   the specified extrinsic and intrinsic camera parameters *)
 Procedure cvProjectPoints2( const object_points, rotation_vector: PCvMat;
                             const translation_vector, intrinsic_matrix: PCvMat;
                             const distortion_coeffs: PCvMat;
                             image_points: PCvMat;
                             dpdrot: PCvMat = nil; dpdt: PCvMat = nil;
                             dpdf:   PCvMat = nil; dpdc: PCvMat = nil;
                             dpddist: PCvMat = nil ); cdecl;

(* finds extrinsic camera parameters from
   a few known corresponding point pairs and intrinsic parameters *)
 Procedure cvFindExtrinsicCameraParams2(  const object_points, image_points: PCvMat;
                                          const intrinsic_matrix, distortion_coeffs: PCvMat;
                                          rotation_vector: PCvMat;
                                          translation_vector: PCvMat ); cdecl;


 (* Does perspective transform on every element of input array *)
 Procedure  cvPerspectiveTransform( const src: PCvArr;
                                        dst: PCvArr;
                                     const mat: PCvMat ); cdecl;


 (* Warps image with perspective (projective) transform *)
 Procedure  cvWarpPerspective( const src, dst: PCvArr; const map_matrix: PCvMat;
                                flags: integer ;
                                fillval: CvScalar); cdecl;

(* Computes perspective transform matrix for mapping src[i] to dst[i] (i=0,1,2,3) *)
 Function cvGetPerspectiveTransform( const src: PCvPoint2D32f;
                                     const dst: PCvPoint2D32f;
                                     map_matrix: PCvMat ): PCvMat; cdecl;


 (* computes transformation map from intrinsic camera parameters
   that can used by cvRemap *)
 Procedure cvInitUndistortMap( const intrinsic_matrix: PCvMat;
                                const distortion_coeffs: PCvMat;
                                mapx, mapy: PCvArr ); cdecl;
 { Performs generic geometric transformation using the specified coordinate maps }
 Procedure  cvRemap( const src, dst: PCvArr;
                      const mapx, mapy: PCvArr;
                      flags: integer ;
                      fillval: CvScalar ); cdecl;

  {***************************************************************************************\
  *                         Error  functions                                              *
  \*************************************************************************************** }
 function cvGetErrStatus( ): integer; cdecl;
 procedure cvSetErrStatus(status: integer ); cdecl;
 function cvErrorStr(status: integer ): PCvChar; cdecl;

 type cvErrorCallback = function (
        status: integer;
        const func_name: PCvChar;
        const err_msg: PCvChar;
        const file_name: PCvChar;
        line: integer;
        user_data: Pointer = nil ): integer; cdecl;

 function cvError: cvErrorCallback;  cdecl;
 function cvRedirectError(
        error_handler: cvErrorCallback;
        userdata: Pointer = nil;
        prev_userdata: PPointer = nil ): CvErrorCallback; cdecl;

/////////////////////// FACE DETECT ///////////////////
const
  CV_HAAR_FEATURE_MAX = 3;

Type
  pCvHaarFeature = ^TCvHaarFeature;

  TCvHaarFeatureRect = record
    r: CvRect;
    weight: Float;
  end;

  TCvHaarFeature = record
    tilted: Integer; // int tilted;
    // struct
    // {
    // CvRect r;
    // float weight;
    // } rect[CV_HAAR_FEATURE_MAX];
    rect: array [0 .. CV_HAAR_FEATURE_MAX - 1] of TCvHaarFeatureRect;
  end;

  pCvHaarClassifier = ^TCvHaarClassifier;

  TCvHaarClassifier = record
    count: Integer; // int count;
    haar_feature: pCvHaarFeature; // CvHaarFeature* haar_feature;
    threshold: pFloat; // float* threshold;
    left: pInteger; // int* left;
    right: pInteger; // int* right;
    alpha: pFloat; // float* alpha;
  end;

  pCvHaarStageClassifier = ^TCvHaarStageClassifier;

  TCvHaarStageClassifier = record
    count: Integer; // int  count;
    threshold: Float; // float threshold;
    classifier: pCvHaarClassifier; // CvHaarClassifier* classifier;
    next: Integer; // int next;
    child: Integer; // int child;
    parent: Integer; // int parent;
  end;

  // typedef struct CvHidHaarClassifierCascade CvHidHaarClassifierCascade;
  TCvHidHaarClassifierCascade = record

  end;

  pCvHidHaarClassifierCascade = ^TCvHidHaarClassifierCascade;
  pCvHaarClassifierCascade = ^TCvHaarClassifierCascade;

  // typedef struct CvHaarClassifierCascade
  TCvHaarClassifierCascade = record
    flags: Integer; // int  flags;
    count: Integer; // int  count;
    orig_window_size: TCvSize; // CvSize orig_window_size;
    real_window_size: TCvSize; // CvSize real_window_size;
    scale: Double; // double scale;
    stage_classifier: pCvHaarStageClassifier; // CvHaarStageClassifier* stage_classifier;
    hid_cascade: pCvHidHaarClassifierCascade; // CvHidHaarClassifierCascade* hid_cascade;
  end;

Const
  CV_HAAR_DO_CANNY_PRUNING = 1;
  CV_HAAR_SCALE_IMAGE = 2;
  CV_HAAR_FIND_BIGGEST_OBJECT = 4;
  CV_HAAR_DO_ROUGH_SEARCH = 8;

function cvHaarDetectObjects(const image: pCvArr; cascade: pCvHaarClassifierCascade; storage: pCvMemStorage; scale_factor: Double { 1.1 };
  min_neighbors: Integer { 3 }; flags: Integer { 0 }; min_size: TCvSize { CV_DEFAULT(cvSize(0,0)) }; max_size: TCvSize { CV_DEFAULT(cvSize(0,0)) } )
  : pCvSeq; cdecl;
function CvSize(const width, height: Integer): TCvSize;

{*****************************************************************************}
implementation

uses
  Dialogs;

  function CvSize;
  begin
    Result.width := width;
    Result.height := height;
  end;

 function cvHaarDetectObjects;            external objdetect_lib;

 function cvAlloc;                        external cxCore name 'cvAlloc';
 procedure cvFree;                        external cxCore name 'cvFree_';
 procedure cvRelease;                     external cxCore name 'cvRelease';
 Function  cvInitMatHeader;               external cxCore name 'cvInitMatHeader';
 Function  cvCreateMatHeader;             external cxCore name 'cvCreateMatHeader';
 Procedure cvSetData;                     external cxCore name 'cvSetData';
 Function  cvCreateMemStorage;            external cxCore name 'cvCreateMemStorage';
 Procedure cvClearMemStorage;             external cxCore name 'cvClearMemStorage';
 Procedure cvReleaseMemStorage;           external cxCore name 'cvReleaseMemStorage';
 Procedure cvReleaseData;                 external cxCore name 'cvReleaseData';
 Function  cvCreateMat;                   external cxCore name 'cvCreateMat';
 Procedure cvReleaseMat;                  external cxCore name 'cvReleaseMat';
 Function  cvGetRows;                     external cxCore name 'cvGetRows';

 Function  cvLoad;                        external cxCore name 'cvLoad';
 Procedure cvSave;                        external cxCore name 'cvSave';


 function cvCreateImage;                  external cxCore name 'cvCreateImage';
 Function  cvCloneImage;                  external cxCore name 'cvCloneImage';
 Function  cvGetSubRect;                  external cxCore name 'cvGetSubRect';
 {cause error in Delphi
 function cvGetSize;                      external cxCore name 'cvGetSize'; }
 procedure cvCopy;                        external cxCore name 'cvCopy';
 procedure cvNot;                         external cxCore name 'cvNot';
 procedure cvInRangeS;                    external cxCore name 'cvInRangeS';
 procedure cvSet;                         external cxCore name 'cvSet';
 procedure cvSetZero;                     external cxCore name 'cvSetZero';
 procedure cvZero;                        external cxCore name 'cvSetZero';
 procedure cvSetImageROI;                 external cxCore name 'cvSetImageROI';
 procedure cvSetImageCOI;                 external cxCore name 'cvSetImageCOI';
 procedure cvResetImageROI;               external cxCore name 'cvResetImageROI';
 procedure cvConvertScale;                external cxCore name 'cvConvertScale';
 procedure cvSplit;                       external cxCore name 'cvSplit';
 procedure cvMerge;                       external cxCore name 'cvMerge';
 procedure cvAnd;                         external cxCore name 'cvAnd';
 procedure cvOr;                          external cxCore name 'cvOr';
 procedure cvXor;                         external cxCore name 'cvXor';
 procedure cvCmp;                         external cxCore name 'cvCmp';
 function cvGetReal1D;                    external cxCore name 'cvGetReal1D';
 function cvGetReal2D;                    external cxCore name 'cvGetReal2D';
 function cvGetReal3D;                    external cxCore name 'cvGetReal3D';
 function cvGetRealND;                    external cxCore name 'cvGetRealND';
 function cvGet1D;                        external cxCore name 'cvGet1D';
 function cvGet2D;                        external cxCore name 'cvGet2D';
 function cvGet3D;                        external cxCore name 'cvGet3D';
 function cvGetND;                        external cxCore name 'cvGetND';
 procedure cvSet1D;                       external cxCore name 'cvSet1D';
 procedure cvSet2D;                       external cxCore name 'cvSet2D';
 procedure cvSet3D;                       external cxCore name 'cvSet3D';
 procedure cvSetND;                       external cxCore name 'cvSetND';
 procedure cvXorS;                        external cxCore name 'cvXorS';
 procedure cvLine;                        external cxCore name 'cvLine';
 procedure cvPolyLine;                    external cxCore name 'cvPolyLine';
 procedure cvRectangle;                   external cxCore name 'cvRectangle';
 procedure cvEllipse;                     external cxCore name 'cvEllipse';
 procedure cvCircle;                      external cxCore name 'cvCircle';
 procedure cvInitFont;                    external cxCore name 'cvInitFont';
 procedure cvPutText;                     external cxCore name 'cvPutText';
 Procedure cvReleaseImage;                external cxCore name 'cvReleaseImage';
 Function  cvSum;                         external cxCore name 'cvSum';
 Function  cvCountNonZero;                external cxCore name 'cvCountNonZero';
 Procedure cvSub;                         external cxCore name 'cvSub';
 Procedure cvAdd;                         external cxCore name 'cvAdd';
 Procedure cvAddS;                        external cxCore name 'cvAddS';
 Procedure cvMul;                         external cxCore name 'cvMul';
 Function  cvNorm;                        external cxCore name 'cvNorm';
 Function  cvAvg;                         external cxCore name 'cvAvg';
 Procedure cvAvgSdv;                      external cxCore name 'cvAvgSdv';
 Procedure cvLog;                         external cxCore name 'cvLog';
 Procedure cvDFT;                         external cxCore name 'cvDFT';
 Function  cvGetOptimalDFTSize;           external cxCore name 'cvGetOptimalDFTSize';
 Procedure cvCartToPolar;                 external cxCore name 'cvCartToPolar';
 Procedure cvPolarToCart;                 external cxCore name 'cvPolarToCart';
 Procedure cvMinMaxLoc;                   external cxCore name 'cvMinMaxLoc';
 Function  cvCreateSeq;                   external cxCore name 'cvCreateSeq';
 Function  cvGetSeqElem;                  external cxCore name 'cvGetSeqElem';
 Procedure cvDrawContours;                external cxCore name 'cvDrawContours';
 Procedure cvKMeans2;                     external cxCore name 'cvKMeans2';
 Procedure cvPerspectiveTransform;        external cxCore name 'cvPerspectiveTransform';

 Function  cvGetErrStatus;                external cxCore name 'cvGetErrStatus';
 Procedure cvSetErrStatus;                external cxCore name 'cvSetErrStatus';
 Function  cvErrorStr;                    external cxCore name 'cvErrorStr';
 Function  cvError;                       external cxCore name 'cvError';
 Function  cvRedirectError;               external cxCore name 'cvRedirectError';



 Procedure cvCreateData;                  external cvDLL name 'cvCreateData';
 Function  cvCreateImageHeader;           external cvDLL name 'cvCreateImageHeader';
 Procedure cvReleaseImageHeader;          external cvDLL name 'cvReleaseImageHeader';
 Procedure cvCalibrateCamera;             external cvDLL name 'cvCalibrateCamera';
 Function  cvInvert;                      external cvDLL name 'cvInvert';
 Procedure cvMultiplyAcc;                 external cvDLL name 'cvMultiplyAcc';
 Procedure cvCvtColor;                    external cvDLL name 'cvCvtColor';
 Procedure cvResize;                      external cvDLL name 'cvResize';
 Procedure cvFindCornerSubPix;            external cvDLL name 'cvFindCornerSubPix';
 function  cvCreateHist;                  external cvDLL name 'cvCreateHist';
 Procedure cvReleaseHist;                 external cvDLL name 'cvReleaseHist';
 procedure cvCalcArrHist;                 external cvDLL name 'cvCalcArrHist';
 procedure cvGetMinMaxHistValue;          external cvDLL name 'cvGetMinMaxHistValue';
 procedure cvCalcArrBackProject;          external cvDLL name 'cvCalcArrBackProject';
 procedure cvEqualizeHist;                external cvDLL name 'cvEqualizeHist';
 procedure cvGoodFeaturesToTrack;         external cvDLL name 'cvGoodFeaturesToTrack';
 procedure cvCornerHarris;                external cvDLL name 'cvCornerHarris';
 function   cvHoughLines2;                external cvDLL name 'cvHoughLines2';
 function   cvHoughCircles;               external cvDLL name 'cvHoughCircles';
 procedure  cvFitLine;                    external cvDLL name 'cvFitLine';
 function   cvFitEllipse2;                external cvDLL name 'cvFitEllipse2';
 function   cvMinEnclosingCircle;         external cvDLL name 'cvMinEnclosingCircle';
 procedure  cvSobel;                      external cvDLL name 'cvSobel';
 procedure  cvLaplace;                    external cvDLL name 'cvLaplace';
 Procedure  cvPyrDown;                    external cvDLL name 'cvPyrDown';
 Procedure  cvPyrUp;                      external cvDLL name 'cvPyrUp';
 Procedure  cvPyrMeanShiftFiltering;      external cvDLL name 'cvPyrMeanShiftFiltering';
 Procedure  cvCanny;                      external cvDLL name 'cvCanny';
 Function   cvCreateStructuringElementEx; external cvDLL name 'cvCreateStructuringElementEx';
 Procedure  cvReleaseStructuringElement;  external cvDLL name 'cvReleaseStructuringElement';
 Procedure  cvErode;                      external cvDLL name 'cvErode';
 Procedure  cvDilate;                     external cvDLL name 'cvDilate';
 Procedure  cvMorphologyEx;               external cvDLL name 'cvMorphologyEx';
 Procedure  cvCalcMoments;                external cvDLL name 'cvMoments';
 Function   cvGetSpatialMoment;           external cvDLL name 'cvGetSpatialMoment';
 Function   cvGetCentralMoment;           external cvDLL name 'cvGetCentralMoment';
 Function   cvGetNormalizedCentralMoment; external cvDLL name 'cvGetNormalizedCentralMoment';
 Procedure  cvGetHuMoments;               external cvDLL name 'cvGetHuMoments';
 Function   cvMatchShapes;                external cvDLL name 'cvMatchShapes';
 Procedure  cvMatchTemplate;              external cvDLL name 'cvMatchTemplate';
 Procedure  cvThreshold;                  external cvDLL name 'cvThreshold';
 Procedure  cvAdaptiveThreshold;          external cvDLL name 'cvAdaptiveThreshold';
 Procedure  cvCopyMakeBorder;             external cvDLL name 'cvCopyMakeBorder';
 Procedure  cvSmooth;                     external cvDLL name 'cvSmooth';
 Procedure  cvFilter2D;                   external cvDLL name 'cvFilter2D';
 Function   cvFindContours;               external cvDLL name 'cvFindContours';
 Procedure  cvFloodFill;                  external cvDLL name 'cvFloodFill';
 Function   cvApproxPoly;                 external cvDLL name 'cvApproxPoly';
 Function   cvContourArea;                external cvDLL name 'cvContourArea';
 Function   cvArcLength;                  external cvDLL name 'cvArcLength';
 Function   cvCheckContourConvexity;      external cvDLL name 'cvCheckContourConvexity';
 Function   cvConvexHull2;                external cvDLL name 'cvConvexHull2';
 Function   cvBoundingRect;               external cvDLL name 'cvBoundingRect';
 Function   cvSampleLine;                 external cvDLL name 'cvSampleLine';
 Procedure  cvWarpPerspective;            external cvDLL name 'cvWarpPerspective';
 Function   cvGetPerspectiveTransform;    external cvDLL name 'cvGetPerspectiveTransform';
 Procedure  cvInitUndistortMap;           external cvDLL name 'cvInitUndistortMap';
 Procedure  cvRemap;                      external cvDLL name 'cvRemap';
// Functions only in OpenCV V1
{$if not Defined(V3) AND Not Defined(V2)}
 Function   cvFindChessBoardCornerGuesses; external cvDLL name 'cvFindChessBoardCornerGuesses';
{$endif}

 Procedure  cvProjectPoints2;             external calibDLL name 'cvProjectPoints2';
 Procedure  cvFindExtrinsicCameraParams2; external calibDLL name 'cvFindExtrinsicCameraParams2';
 Procedure  cvRodrigues2;                 external calibDLL name 'cvRodrigues2';


// procedure  cvCalcOpticalFlowLK;          external videoDLL name 'cvCalcOpticalFlowLK';
// procedure  cvCalcOpticalFlowBM;          external videoDLL name 'cvCalcOpticalFlowBM';
// procedure  cvCalcOpticalFlowHS;          external videoDLL name 'cvCalcOpticalFlowHS';
// procedure  cvCalcOpticalFlowPyrLK;       external videoDLL name 'cvCalcOpticalFlowPyrLK';
// function   cvCamShift;                   external videoDLL name 'cvCamShift';

 procedure  cvCalcOpticalFlowLK;          external legacyDLL name 'cvCalcOpticalFlowLK';
 procedure  cvCalcOpticalFlowBM;          external legacyDLL name 'cvCalcOpticalFlowBM';
 procedure  cvCalcOpticalFlowHS;          external legacyDLL name 'cvCalcOpticalFlowHS';
 procedure  cvCalcOpticalFlowPyrLK;       external videoDLL name 'cvCalcOpticalFlowPyrLK';
 function   cvCamShift;                   external videoDLL name 'cvCamShift';

{ Obsolete functions from 1.00 version }
{$ifndef HIGHGUI_NO_BACKWARD_COMPATIBILITY}
    {$define HIGHGUI_BACKWARD_COMPATIBILITY}
{$endif}                                           

{$ifdef HIGHGUI_BACKWARD_COMPATIBILITY}
 function cvCaptureFromFile;              external HighGUI_DLL name 'cvCreateFileCapture';
 function cvCaptureFromCAM;               external HighGUI_DLL name 'cvCreateCameraCapture';
{$endif}
 function cvCreateFileCapture;            external HighGUI_DLL name 'cvCreateFileCapture';
 function cvCreateCameraCapture;          external HighGUI_DLL name 'cvCreateCameraCapture';
 Function  cvLoadImage;                   external HighGUI_DLL name 'cvLoadImage';
 Function  cvSaveImage;                   external HighGUI_DLL name 'cvSaveImage';
 function  cvGrabFrame;                   external HighGUI_DLL name 'cvGrabFrame';
 function  cvRetrieveFrame;               external HighGUI_DLL name 'cvRetrieveFrame';
 function  cvQueryFrame;                  external HighGUI_DLL name 'cvQueryFrame';
 procedure cvReleaseCapture;              external HighGUI_DLL name 'cvReleaseCapture';
 function  cvSetCaptureProperty;          external HighGUI_DLL name 'cvSetCaptureProperty';
 function  cvGetCaptureProperty;          external HighGUI_DLL name 'cvGetCaptureProperty';
 function  cvCreateVideoWriter;           external HighGUI_DLL name 'cvCreateVideoWriter';
 function  cvWriteFrame;                  external HighGUI_DLL name 'cvWriteFrame';
 procedure cvReleaseVideoWriter;          external HighGUI_DLL name 'cvReleaseVideoWriter';
 // new by zbyna
// function  cvFontQt;                      external HighGUI_DLL name 'cvFontQt';
// procedure cvAddText;                     external HighGUI_DLL name 'cvAddText';
// procedure cvDisplayOverlay;              external HighGUI_DLL name 'cvDisplayOverlay';
// procedure cvDisplayStatusBar;            external HighGUI_DLL name 'cvDisplayStatusBar';
// procedure cvSaveWindowParameters;        external HighGUI_DLL name 'cvSaveWindowParameters';
// procedure cvLoadWindowParameters;        external HighGUI_DLL name 'cvLoadWindowParameters';
// function  cvStartLoop;                   external HighGUI_DLL name 'cvStartLoop';
// procedure cvStopLoop;                    external HighGUI_DLL name 'cvStopLoop';
// function  cvCreateButton;                external HighGUI_DLL name 'cvCreateButton';
 function  cvInitSystem;                  external HighGUI_DLL name 'cvInitSystem';
 function  cvStartWindowThread;           external HighGUI_DLL name 'cvStartWindowThread';
 function  cvNamedWindow;                 external HighGUI_DLL name 'cvNamedWindow';
 procedure cvSetWindowProperty;           external HighGUI_DLL name 'cvSetWindowProperty';
 function  cvGetWindowProperty;           external HighGUI_DLL name 'cvGetWindowProperty';
 procedure cvShowImage;                   external HighGUI_DLL name 'cvShowImage';
 procedure cvResizeWindow;                external HighGUI_DLL name 'cvResizeWindow';
 procedure cvMoveWindow;                  external HighGUI_DLL name 'cvMoveWindow';
 procedure cvDestroyWindow;               external HighGUI_DLL name 'cvDestroyWindow';
 procedure cvDestroyAllWindows;           external HighGUI_DLL name 'cvDestroyAllWindows';
 function  cvGetWindowHandle;             external HighGUI_DLL name 'cvGetWindowHandle';
 function  cvGetWindowName;               external HighGUI_DLL name 'cvGetWindowName';
 function  cvCreateTrackbar;              external HighGUI_DLL name 'cvCreateTrackbar';
 function  cvCreateTrackbar2;             external HighGUI_DLL name 'cvCreateTrackbar2';
 function  cvGetTrackbarPos;              external HighGUI_DLL name 'cvGetTrackbarPos';
 procedure cvSetTrackbarPos;              external HighGUI_DLL name 'cvSetTrackbarPos';
 procedure cvSetMouseCallback;            external HighGUI_DLL name 'cvSetMouseCallback';
 function  cvLoadImageM;                  external HighGUI_DLL name 'cvLoadImageM';
 function  cvDecodeImage;                 external HighGUI_DLL name 'cvDecodeImage';
 function  cvDecodeImageM;                external HighGUI_DLL name 'cvDecodeImageM';
 function  cvEncodeImage;                 external HighGUI_DLL name 'cvEncodeImage';
 procedure cvConvertImage;                external HighGUI_DLL name 'cvConvertImage';//overload;
 function  cvWaitKey;                     external HighGUI_DLL name 'cvWaitKey';
 procedure cvSetOpenGlDrawCallback;       external HighGUI_DLL name 'cvSetOpenGlDrawCallback';
 procedure cvSetOpenGlContext;            external HighGUI_DLL name 'cvSetOpenGlContext';
 procedure cvUpdateWindow;                external HighGUI_DLL name 'cvUpdateWindow';

{----------------------------------------------------}
{ CVCam auxiliary library, only in OpenCV V1 }
{$ifndef V3}
   {$ifndef V2}
 function cvcamGetCamerasCount;           external CvCam       name 'cvcamGetCamerasCount';
 function cvcamSelectCamera;              external CvCam       name 'cvcamSelectCamera';
 function cvcamGetProperty;               external CvCam       name 'cvcamGetProperty';
 function cvcamSetProperty;               external CvCam       name 'cvcamSetProperty';
 function cvcamInit;                      external CvCam       name 'cvcamInit';
 function cvcamStart;                     external CvCam       name 'cvcamStart';
 function cvcamPause;                     external CvCam       name 'cvcamPause';
 function cvcamResume;                    external CvCam       name 'cvcamResume';
 function cvcamStop;                      external CvCam       name 'cvcamStop';
 function cvcamExit;                      external CvCam       name 'cvcamExit';
{$endif}
{$endif}
 {----------------------------------------------------}
 Procedure cvMatMul( A,B,D : PCvArr );
 begin
    cvMultiplyAcc(A,B,nil,D);
 end;


 function CV_MAT_TYPE( flags : integer): integer;
 begin
    Result:=(flags and CV_MAT_TYPE_MASK);
 end;

 function CV_MAT_DEPTH( flags : integer): integer;
 begin
    Result:=(flags and CV_MAT_DEPTH_MASK);
 end;

 function CV_MAT_CN( flags : integer): integer;
 begin
    Result:=((flags and CV_MAT_CN_MASK) shr 3)+1;
 end;

 function CV_ELEM_SIZE( type_ : integer): integer;
 begin
    Result:=(CV_MAT_CN(type_) shl (($e90 shr CV_MAT_DEPTH(type_)*2) and 3));
 end;

 function cvMat_( rows : Integer; cols : Integer; type_: Integer; data : Pointer) : CvMat ;
 var
        mat: CvMat;
 begin
      cvInitMatHeader( @mat, rows, cols, type_, data, CV_AUTOSTEP );
      result := mat;
 end;


 Function cvmGet( const mat : PCvMat; i, j : integer): Single;
 var
  type_ : integer;
  ptr   : PUCHAR;
  pf    : PSingle;
  res   : Single;
 begin
    res := 0;
    type_:= CV_MAT_TYPE(mat.type_);
    assert(  ( i<mat.rows) and (j<mat.cols) );

    if type_ = CV_32FC1 then begin
       ptr:=mat.data.ptr;
       inc(ptr, mat.step*i+ sizeOf(Single)*j);
       pf:=PSingle(ptr);
       res:=pf^;
    end;
    result := res;
 end;


 Procedure cvmSet( mat : PCvMat; i, j : integer; val: Single  );
 var
  type_ : integer;
  ptr   : PUCHAR;
  pf    : PSingle;
 begin
    type_:= CV_MAT_TYPE(mat.type_);
    assert(  ( i<mat.rows) and (j<mat^.cols) );

    if type_ = CV_32FC1 then begin
       ptr:=mat.data.ptr;
       inc(ptr, mat.step*i+ sizeOf(Single)*j);
       pf:=PSingle(ptr);
       pf^:=val;
    end;

 end;

 Function cvPseudoInverse( const src : PCvArr; dst : PCvArr ) : double;
 begin
    cvInvert( src, dst, CV_SVD );
 end;


 Function cvSize_( width, height : integer ) : TcvSize;
 begin
    Result.width:=width;
    Result.height:=height;
 end;

{-----------------------------------}
procedure cvCalcHist(image:P2PIplImage; hist:PCvHistogram; accumulate:longint; mask:PCvArr);
begin
//      cvCalcArrHist( (CvArr**)image, hist, accumulate, mask );
      cvCalcArrHist(p2pCvArr(image), hist, accumulate, mask );

end;

function cvQueryHistValue2D(hist:CvHistogram; idx0:longint; idx1:longint):double;
begin
  result := cvGetReal2D(hist.bins, idx0, idx1);

end;


procedure cvCalcBackProject(image:P2PIplImage; dst:PCvArr; hist:PCvHistogram);
begin
  cvCalcArrBackProject(P2PCvArr(image), dst, hist);
end;

function cvScalar_(val0:double; val1:double; val2:double; val3:double):CvScalar;
var
      scalar: CvScalar ;
begin
      scalar.val[0] := val0; scalar.val[1] := val1;
      scalar.val[2] := val2; scalar.val[3] := val3;
      result := scalar;
end;

function cvScalarAll(val0123:double):CvScalar;
var
        scalar: CvScalar;
begin
      scalar.val[0] := val0123;
      scalar.val[1] := val0123;
      scalar.val[2] := val0123;
      scalar.val[3] := val0123;
      result := scalar;
end;



function cvRound(value:double):longint;
begin
      {*
       the algorithm was taken from Agner Fog's optimization guide
       at http://www.agner.org/assem
       *}
    //  temp := value + 6755399441055744.0;
    //  result := (int)*((uint64*)&temp);
      result := round(value);

end;

function cvFloor(value:double):longint;
begin
        result := floor(value);
end;

function cvPoint_( x, y: longint ): CvPoint;
var
    p: CvPoint;
begin
    p.x := x;
    p.y := y;

    result := p;
end;

function  cvTermCriteria_( type_: longint; max_iter: longint; epsilon: double ): CvTermCriteria;
var
    t: CvTermCriteria;
begin
    t.type_ := type_;
    t.maxIter := max_iter;
    t.epsilon := epsilon;

    result := t;
end;

function CV_RGB(r,g,b : longint) : CvScalar;
begin
   CV_RGB := cvScalar_(b,g,r,0);
end;

function  cvPointFrom32f_( point: CvPoint2D32f ): CvPoint;
var
    ipt: CvPoint;
begin
    ipt.x := cvRound(point.x);
    ipt.y := cvRound(point.y);

    result := ipt;
end;

function  cvPointTo32f_(point: CvPoint ):  CvPoint2D32f;
var
    ipt: CvPoint2D32f;
begin
    ipt.x := point.x;
    ipt.y := point.y;
    result := ipt;
end;

procedure cvEllipseBox(img:PCvArr; box:CvBox2D; color:CvScalar; thickness:longint;
              line_type:longint; shift:longint);
var
      axes: TCvSize;
begin
      axes.width := cvRound(box.size.height *0.5);
      axes.height := cvRound(box.size.width *0.5);

      cvEllipse( img, cvPointFrom32f_( box.center ), axes, (box.angle*180/pi),
                 0, 360, color, thickness, line_type, shift );
end;

function  cvRect_( x, y, width, height: longint ): CvRect;
var
    r: CvRect;
begin
    r.x := x;
    r.y := y;
    r.width := width;
    r.height := height;

    result := r;
end;

procedure CV_SWAP(var a, b, t: pointer);
begin
        t := a;
        a := b;
        b := t;
end;

function cvGetSize(arr: PIplImage):TCvSize;
var
 cs: TCvSize;
begin
        cs.width := arr^.Width;
        cs.height := arr^.Height;
        result := cs;
end;


Function  cvSlice_(start, end_: longint ): CvSlice;
var
    slice: CvSlice ;
begin
    slice.start_index := start;
    slice.end_index := end_;

    result := slice;
end;

//#define cvContourPerimeter( contour ) cvArcLength( contour, CV_WHOLE_SEQ, 1 )
function cvContourPerimeter( contour: PCvSeq ): double;
begin
        result := cvArcLength( contour, CV_WHOLE_SEQ, 1 );
end;


//#define CV_FOURCC(c1,c2,c3,c4)  \
//    (((c1)&255) + (((c2)&255)<<8) + (((c3)&255)<<16) + (((c4)&255)<<24))
function CV_FOURCC(ch1, ch2, ch3, ch4: CvChar): integer;
var
        c1, c2, c3, c4: byte;
begin
    c1 := ord(ch1);
    c2 := ord(ch2);
    c3 := ord(ch3);
    c4 := ord(ch4);

    result := ( ((c1) and 255) + ( ((c2) and 255) shl 8) + ( ((c3) and 255) shl 16) + ( ((c4) and 255) shl 24) );
end;

{-----------------------------------------------------------------------------
  Procedure:  IplImage2Bitmap
  Author:     K.Otani
  Date:       25-Oct-2017
  Arguments:  iplImg: PIplImage; bitmap: TBitmap
  Description: Convert IplImage to Bitmap for Raspberry pi
  refer to
  http://lazarus-ccr.sourceforge.net/docs/lcl/graphtype/trawimagedescription.html
-----------------------------------------------------------------------------}
procedure iplImage2Bitmap(img: PIplImage;var bmp:TBitmap);
var
    ImgPtr      : PByte;
    offset      : Longword;
    x,y         : Integer;
    PxlPtr      : PByte;
    LinePtr     : PByte;
    RawImage    : TRawImage;
    bmp2        : TBitmap;
    BytePerPixel: Integer;
begin
    bmp2:=TBitmap.Create;
    bmp2.Width:=img^.Width;
    bmp2.Height:=img^.Height;

    RawImage:= bmp2.RawImage;
    BytePerPixel := RawImage.Description.BitsPerPixel div 8;

    LinePtr := RawImage.Data;
    ImgPtr:=img^.ImageData;

    if img^.NChannels=3 then
     begin
       for y:=0 to img^.Height-1 do
       begin
          PxlPtr := LinePtr;
          for x:=0 to img^.Width-1 do
            begin
               offset  :=(img^.WidthStep*y)+(x*3);
               PxlPtr^ :=ImgPtr[offset+0]; Inc(PxlPtr);
               PxlPtr^ :=ImgPtr[offset+1]; Inc(PxlPtr);
               PxlPtr^ :=ImgPtr[offset+2]; Inc(PxlPtr);
               if BytePerPixel = 4 then    Inc(PxlPtr);// BytePerPixel = 4bytes (RaspberryPi)
            end;
          // There might be gap at the end of line
          Inc(LinePtr, RawImage.Description.BytesPerLine);
       end;
     end;

     if img^.NChannels=1 then
     begin
       for y:=0 to img^.Height-1 do

         begin
            PxlPtr := LinePtr;
            for x:=0 to img^.Width-1 do
               begin
                 offset  :=(img^.WidthStep*y)+(x);
                 PxlPtr^ :=ImgPtr[offset]; Inc(PxlPtr);
                 PxlPtr^ :=ImgPtr[offset]; Inc(PxlPtr);
                 PxlPtr^ :=ImgPtr[offset]; Inc(PxlPtr);
                 if BytePerPixel = 4 then  Inc(PxlPtr);// BytePerPixel = 4bytes (RaspberryPi)
               end;
            Inc(LinePtr, RawImage.Description.BytesPerLine);
         end;
     end;
     bmp.Assign(bmp2);
     bmp2.free;
end;

{-----------------------------------------------------------------------------
  Procedure:  Bitmap2IplImage
  Author:     G. De Sanctis
  Date:       15-may-2007
  Arguments:  iplImg: PIplImage; bitmap: TBitmap
  Description: create a new IplImage and convert a Windows bitmap (24 bit) to it
-----------------------------------------------------------------------------}
procedure Bitmap2IplImage(iplImg: PIplImage;  bitmap: TBitmap);
  VAR
    dataByte :  PByteArray;
    RowIn    :  pByteArray;
    lazImg: TLazIntfImage;
BEGIN
  TRY
    assert((iplImg.Depth = 8) and (iplImg.NChannels = 3),
                'Not a 24 bit color iplImage!');
    iplimg.Origin := IPL_ORIGIN_BL;
    iplImg.ChannelSeq := 'BGR';

    lazImg := TLazIntfImage.Create(bitmap.Width, bitmap.Height);
    lazImg.LoadFromBitmap(bitmap.Handle, bitmap.MaskHandle);
    RowIn  := lazImg.GetDataLineStart(bitmap.height -1 );
    dataByte := pbytearray(iplimg.ImageData);
    {direct copy of the bitmap row bytes to iplImage rows}
    Move(rowin^, dataByte^, iplimg.ImageSize);
    lazImg.Free;
  Except
        on E: Exception do
        begin
             raise  Exception.Create('Bitmap2IplImage- error - ' + e.Message);
        end;
  END
END; {Bitmap2IplImage}
{-----------------------------------------------------------------------------
  Procedure:  IplImage32FTo8Bit
  Author:     G. De Sanctis
  Date:       23-set-2005
  Arguments:  img32: PIplImage; img8: PIplImage
  Description: convert a 32 bit IplImage to a 8 bit IplImage
-----------------------------------------------------------------------------}
procedure IplImage32FTo8Bit(Img32, Img8: PIplImage);
  VAR
    scale, shift, diff: Double;
    minVal, maxVal: Double;
    a, b: CvPoint;


  begin
  TRY
    assert((Img32.Depth = 32) and (Img8.Depth = 8)
                and ( ((Img8.NChannels = 1) and (Img32.NChannels = 1))  ),
                'Input must be 32F, 1 channel; output must be 8U, 1 channel!');



    //src =  IplImage * - depth = IPL_DEPTH_32F, nChannels =1
    //dest = IplImage * - depth = IPL_DEPTH_8U, nChannels =1 (gray)


    cvMinMaxLoc(img32,  @minVal, @maxVal, a, b);
    diff := maxVal - minVal;
    if diff <>0 then
        scale := 255/diff
    else
        scale := 0;
    shift := -minVal*scale;

    cvConvertScale (img32, img8, scale, shift);

  Except
        on E: Exception do
        begin
             raise  Exception.Create('IplImage32FTo8Bit- error - ' + e.Message);
        end;

  END; //try
  end;



{-----------------------------------------------------------------------------
  Procedure: cvDelphiErrorHandler
        Delphi specific OpenCV error handler
  Author:    gds
  Date:      25-dic-2009
  Arguments: status: integer; const func_name: PCvChar; const err_msg: PCvChar; const file_name: PCvChar; line: integer
  Result:    integer
-----------------------------------------------------------------------------}
  function cvDelphiErrorHandler(status: integer;
        const func_name: PCvChar;
        const err_msg: PCvChar;
        const file_name: PCvChar;
        line: integer;
        user_data: pointer ): integer; cdecl;
  const
        mrAbort = 3;
        mrIgnore = 5;
  var
        errMsg: string;
        ret: integer;
  begin
        errMsg := err_msg;
        if errMsg = '' then
        begin
                errMsg := cvErrorStr(status);
        end;
//        ret := MessageDlg('OpenCV error in function '+func_name+': '+errMsg,
//                mtError, [mbAbort, mbIgnore], 0);
//
//        if (ret = mrAbort) then
//                result := 1
//        else
         begin
                result := 0;
                // reset error status avoiding a cascade of subsequent errors
                cvSetErrStatus(0);
        end;
        Raise Exception.CreateFmt('OpenCV error: in file <<%s>> function <<%s>> line <<%d>> - %s',
                      [file_name, func_name,  line, errMsg]);
  end;


{****************************************************************************}
var
        redirect: cvErrorCallback;
begin
      CV_WHOLE_SEQ :=  cvSlice_(0, CV_WHOLE_SEQ_END_INDEX);
      CV_CANNY_L2_GRADIENT :=  (1 shl 31);

      CV_8UC3 := ( CV_8U + ((3-1) shl CV_CN_SHIFT) );

      redirect := cvRedirectError(cvDelphiErrorHandler);

end.


