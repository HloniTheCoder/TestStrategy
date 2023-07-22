//Moving Average Variables

//The Slow MA has a higher period
//The Fast MA has a lower period

int slow_ma_period_val = 100;

int fast_ma_period_val = 10;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }




//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

//Moving Average Arrays

//The MA Arrays allow us to index ma values

//Slow Period MA Array will store the slower ma data
//Fast Period MA Array will store the faster ma data

   double slow_period_ma[];

   double fast_period_ma[];


//ArraySetAsSeries Function

//This Function will allow to access the most recent
//candle as the first index(index 0)

//The candles prior to the latest can be indexed (1,2,3...)

   ArraySetAsSeries(slow_period_ma, true);

   ArraySetAsSeries(fast_period_ma, true);


//Moving Average Definition

//Access the moving average indicator data

//The Slow MA Handle is the definition for the highest period MA
//The Fast MA Handle is the definition for the slowest period MA

   int slow_ma_handle = iMA(_Symbol, _Period, slow_ma_period_val, 0, MODE_SMA, PRICE_CLOSE);

   int fast_ma_handle = iMA(_Symbol, _Period, fast_ma_period_val, 0, MODE_SMA, PRICE_CLOSE);


//CopyBuffer Function

//Copy the MA Definition data to the MA Array

//Slow MA Handle defines data for the Slow MA Array
//Fast MA Handle defines data for the Fast MA Array

//Access the MA data for the candle at index 1 and the candle at index 2

   CopyBuffer(slow_ma_handle, 0, 1, 2, slow_period_ma);

   CopyBuffer(fast_ma_handle, 0, 1, 2, fast_period_ma);


//MA Data Variables

//Access the current ma value which is the candle at index 1
//The Candle at index 1 is the first item in our ma data array

   double current_slow_ma_value = slow_period_ma[0]; //slow_period_ma[0] is the first array item

   double previous_slow_ma_value = slow_period_ma[1]; //slow_period_ma[1] is the second array item

   double current_fast_ma_value = fast_period_ma[0]; //fast_period_ma[0] is the first array item

   double previous_fast_ma_value = fast_period_ma[1]; //fast_period_ma[1] is the second array item


//Current MA Cross Conditions

//Create Variables to store the condition of whether
//the Current Fast Ma is Above the Slow MA or
//the Current Fast MA is Below the Slow MA

//If the Fast MA is Above the Slow MA it may indicate bullish momentum
//If the Fast MA is Below the Slow MA it may indicate bearish momentum

   bool is_current_fast_above_slow = current_fast_ma_value > current_slow_ma_value;

   bool is_current_fast_below_slow = current_fast_ma_value < current_slow_ma_value;


//Previous MA Cross Condition

//Create Variables to store the condition of whether
//the Previous Fast MA is Above the Slow MA or
//the Previous Fast MA is Below the Slow Ma

   bool is_previous_fast_above_slow = previous_fast_ma_value > previous_slow_ma_value;

   bool is_previous_fast_below_slow = previous_fast_ma_value < previous_slow_ma_value;


//Moving Average Cross Conditions

//If the Current Fast MA is Above the Current Slow MA and
//the Previous Fast MA is Below the Previous Slow MA
//This Indicates a Bullish Crossover

//If the Current Fast MA is Below the Current Slow MA and
//the Previous Fast MA is Above the Previous Slow MA
//This Indicates a Bearish Crossover

   bool is_ma_up_cross = (is_current_fast_above_slow && is_previous_fast_below_slow);

   bool is_ma_down_cross = (is_current_fast_below_slow && is_previous_fast_above_slow);


//MA Bullish Cross Signal

//If there is a Bullish Cross
//Output a Text Signal

   if(is_ma_up_cross)
     {

      Comment("An UP Cross Has Occured");

     }

//If there is a Bearish Cross
//Output a Text Signal

   else
      if(is_ma_down_cross)
        {
         Comment("A DOWN Cross Has Occured");
        }


      //If there is no Cross

      else
        {
         Comment("No Cross Has Happened");
        }

  }
//+------------------------------------------------------------------+
