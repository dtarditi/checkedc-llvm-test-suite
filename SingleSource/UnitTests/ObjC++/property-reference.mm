#import <Cocoa/Cocoa.h>
#import <tr1/memory>
// rdar: //7501812

class Value
{
public:
    explicit Value(int amount) : m_amount(amount){}
    
    int GetAmount() const { return m_amount; }

private:
    int m_amount;
};

typedef std::tr1::shared_ptr<Value> ValuePtr;

@interface ValueUser : NSObject
{
@private
    ValuePtr* _valuePtr;
}
- (id)initWithValue:(ValuePtr&)valuePtr;
@property ValuePtr value;
@end

@implementation ValueUser
- (id)initWithValue:(ValuePtr&)valuePtr
{
    self = [super init];
    _valuePtr = new ValuePtr(valuePtr);
    return self;
}

- (void)setValue:(ValuePtr)valuePtr
{
    *_valuePtr = valuePtr;
}

- (ValuePtr)value
{
    return *_valuePtr;
}

- (void)dealloc
{
    delete _valuePtr;
    [super dealloc];
}
@end

int main()
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    ValuePtr valuePtr(new Value(42));
    ValueUser* valueUser = [[ValueUser alloc] initWithValue:valuePtr];
    
#ifdef __clang__
    ::NSLog(@"The value's amount is %d", (valueUser.value)->GetAmount());
#endif
    ::NSLog(@"The value's amount is %d", [valueUser value]->GetAmount());
    
    [valueUser release];
    
    [pool release];
    
    return 0;
}