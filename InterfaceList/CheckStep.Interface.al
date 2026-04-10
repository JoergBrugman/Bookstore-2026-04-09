namespace GetUse.Academy.Bookstore.InterfaceList;

/// <summary>
/// To register your Codeunit implemting this Interface, you have to use following Event-Subscriber:
/// [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Pipeline", OnRegisterCheckSteps, '', false, false)]
/// local procedure "Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "Check Step"]; RecRef: RecordRef)
/// begin
///     if RecRef.Number = Database::"Your Table to check" then
///         Steps.Add(this);
/// end;
/// </summary>
interface "Check Step"
{
    /// <summary>
    /// Performs the Check
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Text.</returns>
    procedure Execute(RecRef: RecordRef): Text;
    /// <summary>
    /// Returns the priority of the check as an integer.
    /// Here, a low number has a high priority and lager numbers have a lower priority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetSequence(): Integer;
    /// <summary>
    /// Determines whether the check should be performed.
    /// </summary>
    /// <param name="RecRef">RecordRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsEnabled(RecRef: RecordRef): Boolean;
}