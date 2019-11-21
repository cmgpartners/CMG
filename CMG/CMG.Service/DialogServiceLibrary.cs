using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Service
{
    public static class DialogServiceLibrary
    {
        public enum MessageBoxButton
        {
            OK = 0,
            OKCancel = 1,
            YesNoCancel = 3,
            YesNo = 4,
        }

        public enum MessageBoxResult
        {
            None = 0,
            OK = 1,
            Cancel = 2,
            Yes = 6,
            No = 7,
        }

        public enum MessageBoxIcon
        {
            None = 0,
            Error = 16,
            Hand = 16,
            Stop = 16,
            Question = 32,
            Exclamation = 48,
            Warning = 48,
            Information = 64,
            Asterisk = 64,
        }
    }
}
