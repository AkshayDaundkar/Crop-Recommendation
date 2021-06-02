/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.svm;

import com.helper.StringHelper;

/**
 *
 * @author Technowings
 */
public class Processing {

    public static String getSuggession(String result) {
        String ans = "";
        if (result.equalsIgnoreCase("High")) {
            ans = "<html>1. Go for a walk<br>  2. Spend time in nature <br> 3. Call a good friend <br> 4. Sweat out tension with a workout <br> 5. Write in your journal <br> 6. Take a long bath <br> 7. Light scented candles<br></html>";
        } else if (result.equalsIgnoreCase("Normal")) {
            ans = "<html>1. Savor a warm cup of coffee or tea <br> 2. Play with a pet <br> 3. Work in your garden <br> 4.Get a massage <br> 5. Curl up with a good book <br> 6. Listen to music <br> 7. Watch a comedy</html>";
        } else {
            ans="<html>Wow..!!! You Are already in Low Level stress</html>";
        }
        return ans;
    }

    public static double getStressPercentage(String attention, String meditation) {
        
        double att= StringHelper.n2d(attention);
        double med=StringHelper.n2d(meditation);
        
        
        return att;
        
    }
}
