using System;
using System.Collections.Generic;
using System.Text;
using static CMG.Service.DialogServiceLibrary;

namespace CMG.Service.Interface
{
    public interface IDialogService
    {
        MessageBoxResult ShowMessageBox(string message);
        MessageBoxResult ShowMessageBox(string message, string caption, MessageBoxButton buttons, MessageBoxIcon icon);
    }
}
