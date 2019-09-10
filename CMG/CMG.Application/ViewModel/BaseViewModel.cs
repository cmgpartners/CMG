﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using CMG.Application.Command;

namespace CMG.Application.ViewModel
{
    public class BaseViewModel : INotifyPropertyChanged
    {
        protected BaseViewModel()
        {
            //DispatcherObject = CoreWindow.GetForCurrentThread().Dispatcher;
            CommandManager.AssignOnPropertyChanged(ref this.PropertyChanged);
            _commandsList = new List<RelayCommand>();
        }

        private List<RelayCommand> _commandsList;

        protected RelayCommand CreateCommand(Action execute)
        {
            return CreateCommand(execute, null);
        }

        protected RelayCommand CreateCommand(Action execute, Func<bool> canExecute)
        {
            var tempCmd = new RelayCommand(execute, canExecute);
            if (_commandsList.Contains(tempCmd))
            {
                return _commandsList[_commandsList.IndexOf(tempCmd)];
            }
            else
            {
                _commandsList.Add(tempCmd);
                return tempCmd;
            }
        }

        public void RemoveCommands()
        {
            for (var i = 0; i < _commandsList.Count; i++)
            {
                _commandsList[i].RemoveCommand();
            }
        }

        //public virtual CoreDispatcher DispatcherObject { get; protected set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void ChangeProperty<T>(ref T property, T value, [CallerMemberName] string propertyName = null)
        {
            if (Object.Equals(property, value))
            {
                return;
            }
            else
            {
                property = value;

                OnPropertyChanged(propertyName);
            }
        }

        protected void OnPropertyChangedEmpty()
        {
            OnPropertyChanged(String.Empty);
        }

        protected void OnPropertyChanged(string propertyName)
        {
            var handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    }
}
