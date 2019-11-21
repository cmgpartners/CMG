using CMG.Service.Dialogs;
using CMG.Service.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using static CMG.Service.DialogServiceLibrary;

namespace CMG.Service
{
    public class DialogService : IDialogService
    {
        public MessageBoxResult ShowMessageBox(string message, string caption, MessageBoxButton buttons, MessageBoxIcon icon)
        {
            return (MessageBoxResult)System.Windows.MessageBox.Show(message, caption,
                (System.Windows.MessageBoxButton)buttons,
                (System.Windows.MessageBoxImage)icon);
        }

        public MessageBoxResult ShowMessageBox(string message)
        {
            DialogView dialogBox = new DialogView(message);

            if((bool)dialogBox.ShowDialog())
            {
                return MessageBoxResult.Yes;
            }
            else
            {
                return MessageBoxResult.No;
            }
        }
    }
}
