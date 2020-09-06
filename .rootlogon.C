{
    gROOT->SetStyle("Plain");
//     gStyle->SetPalette(kRainBow);
    gStyle->SetPalette(kGreyScale);
    TColor::InvertPalette();

    Int_t icol=0; // WHITE
    gStyle->SetFrameBorderMode(icol);
    gStyle->SetFrameFillColor(icol);
    gStyle->SetCanvasBorderMode(icol);
    gStyle->SetCanvasColor(icol);
    gStyle->SetPadBorderMode(icol);
    gStyle->SetPadColor(icol);
    gStyle->SetStatColor(icol);
//     gStyle->SetFillColor(icol); // don't use: white fill color for *all* objects

     gStyle->SetPaperSize(20,26);
//    gStyle->SetPaperSize(297,210);

    gStyle->SetPadTopMargin(0.05);
    gStyle->SetPadRightMargin(0.18);
    gStyle->SetPadBottomMargin(0.12);
    gStyle->SetPadLeftMargin(0.12);

    gStyle->SetTitleOffset( 1.0 , "x" );
    gStyle->SetTitleOffset( 1.0 , "y" );
    gStyle->SetTitleOffset( 1.2 , "z" );

    // use large fonts

    Int_t font=42; // Helvetica
//     Int_t font=72; // Helvetica italics
    Double_t tsize=0.05;

    gStyle->SetTextFont(font);
    gStyle->SetTextSize(tsize);

    gStyle->SetLabelFont(font,"x");
    gStyle->SetTitleFont(font,"x");
    gStyle->SetLabelFont(font,"y");
    gStyle->SetTitleFont(font,"y");
    gStyle->SetLabelFont(font,"z");
    gStyle->SetTitleFont(font,"z");

    gStyle->SetLabelSize(tsize,"x");
    gStyle->SetTitleSize(tsize,"x");
    gStyle->SetLabelSize(tsize,"y");
    gStyle->SetTitleSize(tsize,"y");
    gStyle->SetLabelSize(tsize,"z");
    gStyle->SetTitleSize(tsize,"z");

    // use bold lines and markers
    gStyle->SetMarkerStyle(20);
    gStyle->SetMarkerSize(1.2);
    gStyle->SetHistLineWidth(2.);
    gStyle->SetLineStyleString(2,"[12 12]"); // postscript dashes

    // get rid of X error bars 
//     gStyle->SetErrorX(0.001);
    // get rid of error bar caps
    gStyle->SetEndErrorSize(0.);

    gStyle->SetOptTitle(0);
    gStyle->SetOptStat(1110);
    gStyle->SetOptFit(0);

    // put tick marks on top and RHS of plots
    gStyle->SetPadTickX(1);
    gStyle->SetPadTickY(1);
    gStyle->SetPalette(55);
    
    gROOT->ForceStyle();

}
